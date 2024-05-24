/*
==========================================================
THIS FILE WAS MADE BY DONNOVAN FROM BRAZIL
check BRPVP_lisence.txt FOR THE LISENCE

MORE INFORMATION:
http://www.brpvp.com
http://www.brpvp.com.br

DONNOVAN ON STEAM: 
https://steamcommunity.com/profiles/76561197975554637/
==========================================================
*/

//WEATHER FUNCTIONS
BRPVP_weatherWindChanged = {
	params ["_windNew","_windCompare","_maxAngle","_maxMag"];
	private _dac = acos (_windNew vectorCos _windCompare) >= _maxAngle;
	private _dmc = abs (vectorMagnitude _windNew-vectorMagnitude _windCompare) >= _maxMag;
	if (_dac || _dmc) then {
		BRPVP_weatherServerWind = _windNew;
		publicVariable "BRPVP_weatherServerWind";
		_windNew
	} else {
		_windCompare
	};
};
BRPVP_weatherChangeWindSmooth = {
	private _windVec = _this;
	private _wVecNow = wind;
	private _wInit = diag_tickTime;
	private _vInit = diag_tickTime;
	waitUntil {
		private _wait = 1/20;
		private _t = ((diag_tickTime-_wInit)/20) min 1;
		private _nw = (_windVec vectorMultiply _t) vectorAdd (_wVecNow vectorMultiply (1-_t));
		private _fps = diag_fps;
		private _w = (_nw select [0,2])+[true];
		setWind _w;
		if (diag_tickTime-_vInit > 2) then {
			BRPVP_weatherServerWind = _nw;
			publicVariable "BRPVP_weatherServerWind";
			_vInit = diag_tickTime;
		};
		if (1/_fps <= _wait) then {uiSleep _wait;} else {if (random 1 < (1/((1/_fps)/_wait))) then {uiSleep 0.001;};};
		_t isEqualTo 1
	};
};

//WEATHER CHANGE CODE
private _windLast = wind;
private _ovc = BRPVP_weatherInitialOvercast;
private _averageOvercast = BRPVP_weatherInitialOvercast;
private _oRange = BRPVP_maxOvercast-BRPVP_minOvercast;
BRPVP_maxChange = BRPVP_maxChange min _oRange;
BRPVP_minChange = BRPVP_minChange min _oRange;
waitUntil {
	if (random 1 < BRPVP_chanceToChangeWeather) then {
		private _limUp = ((_ovc+BRPVP_maxChange) min 1)-((_ovc+BRPVP_minChange) min 1);
		private _limDown = ((_ovc-BRPVP_minChange) max 0)-((_ovc-BRPVP_maxChange) max 0);
		private _oNew = if (_limUp+_limDown isEqualTo 0) then {BRPVP_minOvercast+random (BRPVP_maxOvercast-BRPVP_minOvercast)} else {if (random (_limUp+_limDown) <= _limUp) then {_ovc+BRPVP_minChange+random _limUp} else {_ovc-BRPVP_minChange-random _limDown};};

		//RAIN
		private _rainChance = if (_oNew <= 0.5) then {0} else {BRPVP_weatherChanceOfRainMin+2*(_oNew-0.5)*(BRPVP_weatherChanceOfRainMax-BRPVP_weatherChanceOfRainMin)};
		private _willRain = random 1 < _rainChance;
		private _rainStart = (_ovc+(_oNew-_ovc)/2) max 0.5;
		private _rainForce = (_oNew-0.125+random 0.25) min 1;
		private _rainStarted = false;

		//WIND
		private _windAngle = random 360;
		private _windMin = BRPVP_weatherWindMin*(1-_oNew)+BRPVP_weatherWindMinWithClouds*_oNew;
		private _windMax = BRPVP_weatherwindMax*_oNew+BRPVP_weatherwindMaxNoClouds*(1-_oNew);
		private _windMag = _windMin+random (_windMax-_windMin);
		private _windVec = [_windMag*sin _windAngle,_windMag*cos _windAngle,0];
		private _windStart = _ovc+(_oNew-_ovc)/2;
		private _windStarted = false;
		BRPVP_weatherServerWind = wind;
		publicVariable "BRPVP_weatherServerWind";
		
		0 setOvercast _oNew;
		_ovc = _oNew;
		[_oNew,_willRain,_windMag] remoteExecCall ["BRPVP_weatherPerkMessage",BRPVP_allNoServer];
		BRPVP_weatherPredictFortClients = [_oNew,_willRain,_windMag];
		publicVariable "BRPVP_weatherPredictFortClients";

		//WAIT FOR CHANGE ON ALL CLIENTS
		waitUntil {
			for "_i" from 1 to 5 do {
				uiSleep 2;
				_windLast = [wind,_windLast,5,1.25] call BRPVP_weatherWindChanged;
			};
			private _afSum = 0;
			private _afCount = 0;
			{
				private _pfn = _x getVariable ["brpvp_client_overcast",-1];
				if (_pfn isNotEqualTo -1) then {_afSum = _afSum+_pfn;_afCount = _afCount+1;};
			} forEach call BRPVP_playersList;
			if (_afCount > 0) then {_averageOvercast = _afSum/_afCount;};
			private _newFog = BRPVP_weatherFogOnOvercastZero+_averageOvercast*(BRPVP_weatherFogOnOvercastOne-BRPVP_weatherFogOnOvercastZero);
			BRPVP_weatherOvercastNow = _averageOvercast;
			if (abs(_newFog-fog) > 0.02) then {10 setFog _newFog;};

			//START RAIN
			if (_willRain && !_rainStarted) then {
				if (_rainStart >= _ovc) then {
					if (_averageOvercast >= _rainStart) then {
						_rainStarted = true;
						15 setRain _rainForce;
						BRPVP_weatherRainOnServer = _rainForce;
						publicVariable "BRPVP_weatherRainOnServer";
					};
				} else {
					if (_averageOvercast <= _rainStart) then {
						_rainStarted = true;
						15 setRain _rainForce;
						BRPVP_weatherRainOnServer = _rainForce;
						publicVariable "BRPVP_weatherRainOnServer";
					};
				};
			};

			//CHANGE WIND
			if (!_windStarted) then {
				if (_windStart >= _ovc) then {
					if (_averageOvercast >= _windStart) then {
						_windStarted = true;
						_windVec call BRPVP_weatherChangeWindSmooth;
					};
				} else {
					if (_averageOvercast <= _windStart) then {
						_windStarted = true;
						_windVec call BRPVP_weatherChangeWindSmooth;
					};
				};
			};

			//FIX SERVER OVERCAST
			if (abs (overcast-_ovc) > 0.02 && BRPVP_iAskForInitialVarsJoining isEqualTo 0) then {0 setOvercast _ovc;};

			abs (_ovc-_averageOvercast) < BRPVP_weatherMaxDiffToChange
		};
		BRPVP_weatherOvercastNow = _ovc;

		//WAIT
		private _init = diag_tickTime;
		private _wait = 2 min BRPVP_waitAfterChangeDone;
		private _fogMantain = BRPVP_weatherFogOnOvercastZero+_ovc*(BRPVP_weatherFogOnOvercastOne-BRPVP_weatherFogOnOvercastZero);
		waitUntil {
			uiSleep _wait;
			if (abs (fog-_fogMantain) > 0.02) then {10 setFog _fogMantain;};
			_windLast = [wind,_windLast,5,1.25] call BRPVP_weatherWindChanged;

			//FIX SERVER OVERCAST
			if (abs (overcast-_ovc) > 0.02 && BRPVP_iAskForInitialVarsJoining isEqualTo 0) then {0 setOvercast _ovc;};

			diag_tickTime-_init > BRPVP_waitAfterChangeDone
		};
	} else {
		//WAIT
		private _init = diag_tickTime;
		private _wait = 2 min BRPVP_waitIfNotChange;
		private _fogMantain = BRPVP_weatherFogOnOvercastZero+_ovc*(BRPVP_weatherFogOnOvercastOne-BRPVP_weatherFogOnOvercastZero);
		waitUntil {
			uiSleep _wait;
			if (abs (fog-_fogMantain) > 0.02) then {10 setFog _fogMantain;};
			_windLast = [wind,_windLast,5,1.25] call BRPVP_weatherWindChanged;

			//FIX SERVER OVERCAST
			if (abs (overcast-_ovc) > 0.02 && BRPVP_iAskForInitialVarsJoining isEqualTo 0) then {0 setOvercast _ovc;};

			diag_tickTime-_init > BRPVP_waitIfNotChange
		};
	};
	false
};
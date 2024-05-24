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

//PMISS PRINCIPAL
private _pmissData = [];
private _pmissActive = [];
{
	private _miss = +(BRPVP_pmissData select _x);
	private _rad = _miss select 2;
	private _aPos = _miss select 3;
	private _aPosExtra = _miss select 4;
	private _canOff = _miss select 9;
	if (_canOff) then {
		private _remove = [];
		{
			private _pos = _x;
			private _hFlag = false;
			{
				private _flag = _x;
				private _fRad = _x call BRPVP_getFlagRadius;
				private _tRad = _rad+_fRad*0.95;
				if (_pos distance2D _flag < _tRad) then {
					_hFlag = true;
					break
				};
			} forEach nearestOBjects [_pos,["FlagCarrier"],_rad+200,true];
			if (_hFlag) then {_remove pushBack _forEachIndex;};
		} forEach _aPos;
		_remove sort false;
		{
			_aPos deleteAt _x;
			_aPosExtra deleteAt _x;
		} forEach _remove;
	};
	if (_aPos isNotEqualTo []) then {
		_miss set [3,_aPos];
		_miss set [4,_aPosExtra];
		_pmissData pushBack _miss;
		_pmissActive pushBack _x;
	};
} forEach BRPVP_pmissActive;

BRPVP_pmissActive = +_pmissActive;
BRPVP_pmissData = +_pmissData;
BRPVP_pmissMaxPerRestart = BRPVP_pmissMaxPerRestart min (count BRPVP_pmissData);

//PMISS SECONDARY
private _pmiss2Data = [];
private _pmiss2Active = [];
{
	private _miss = +(BRPVP_pmiss2Data select _x);
	private _rad = _miss select 2;
	private _aPos = _miss select 3;
	private _aPosExtra = _miss select 4;
	private _canOff = _miss select 9;
	if (_canOff) then {
		private _remove = [];
		{
			private _pos = _x;
			private _hFlag = false;
			{
				private _flag = _x;
				private _fRad = _x call BRPVP_getFlagRadius;
				private _tRad = _rad+_fRad*0.95;
				if (_pos distance2D _flag < _tRad) then {
					_hFlag = true;
					break
				};
			} forEach nearestOBjects [_pos,["FlagCarrier"],_rad+200,true];
			if (_hFlag) then {_remove pushBack _forEachIndex;};
		} forEach _aPos;
		_remove sort false;
		{
			_aPos deleteAt _x;
			_aPosExtra deleteAt _x;
		} forEach _remove;
	};
	if (_aPos isNotEqualTo []) then {
		_miss set [3,_aPos];
		_miss set [4,_aPosExtra];
		_pmiss2Data pushBack _miss;
		_pmiss2Active pushBack _x;
	};
} forEach BRPVP_pmiss2Active;

BRPVP_pmiss2Active = +_pmiss2Active;
BRPVP_pmiss2Data = +_pmiss2Data;
BRPVP_pmiss2MaxPerRestart = BRPVP_pmiss2MaxPerRestart min (count BRPVP_pmiss2Data);
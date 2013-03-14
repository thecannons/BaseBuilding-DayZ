private ["_panelPos","_playerPos","_cnt","_gateAccess","_inVehicle","_soundSource","_panel","_convertInput","_code", "_inputCode", "_validMatch"];
_panel = cursortarget;
_gateAccess = false;
_playerPos = getpos player;
_panelPos = getpos _panel;
_cnt = 600;
keyCode = _this select 0;
//hint format["keycode after enter: %1", keyCode];
sleep 3;
_code = keyCode;
_inputCode = _this select 1;
//hint format["Keycode: %1 | CodeInput: %2", _code, _inputCode];
_convertInput =+ _inputCode;
for "_i" from 0 to (count _convertInput - 1) do {_convertInput set [_i, (_convertInput select _i) + 48]};
//hint format["Keycode: %1 | CodeInput: %2", _code, (toString _convertInput)];

// compare arrays to see if code matches
_validMatch = [_code, (toString _convertInput)] call BIS_fnc_areEqual;


if (_validMatch) then {
	cutText ["### ACCESS GRANTED ###", "PLAIN DOWN"];
	//_soundSource = createSoundSource ["beep", position _panel, [], 25];
	playsound "beep";
	sleep 0.5;
	playsound "beep";
	sleep 0.5;
	playsound "beep";
	keyValid = true;
	_gateAccess = true;
	sleep 2;
	cutText ["You can now operate the bases gate panel(s) for 60 seconds", "PLAIN DOWN"];
	while {_gateAccess} do 
	{
	_playerPos = getpos player;
	_panelPos = getpos _panel;
	//_inVehicle = (vehicle player != player);
		if (_playerPos distance _panelPos > 150) then {
		_gateAccess = false;
		keyValid = false;
		cutText ["Lost connection to panel > 150 meters away", "PLAIN DOWN"];
		};
	_cnt = _cnt - 1;
	if (_cnt == 600 || _cnt == 590 || _cnt == 580 || _cnt == 570 || _cnt == 560 || _cnt == 550 || _cnt == 540 || _cnt == 530 || _cnt == 520 || _cnt == 510 || _cnt == 500 || _cnt == 490 || _cnt == 480 || _cnt == 470 || _cnt == 460 || _cnt == 450 || _cnt == 440 || _cnt == 430 || _cnt == 420 || _cnt == 410 || _cnt == 400 || _cnt == 390 || _cnt == 380 || _cnt == 370 || _cnt == 360 || _cnt == 350 || _cnt == 340 || _cnt == 330 || _cnt == 320 || _cnt == 310 || _cnt == 300 || _cnt == 290 || _cnt == 280 || _cnt == 270 || _cnt == 260 || _cnt == 250 || _cnt == 240 || _cnt == 230 || _cnt == 220 || _cnt == 210 || _cnt == 200 || _cnt == 190 || _cnt == 180 || _cnt == 170 || _cnt == 160 || _cnt == 150 || _cnt == 140 || _cnt == 130 || _cnt == 120 || _cnt == 110 || _cnt == 100 || _cnt == 90 || _cnt == 80 || _cnt == 70 || _cnt == 60 || _cnt == 50 || _cnt == 40 || _cnt == 30 || _cnt == 20 || _cnt == 10 || _cnt == 0) then {
		cutText [format["Access to panel expires in %1 seconds",(_cnt / 10)], "PLAIN DOWN",1];
	};	
		if (_cnt <= 0) then {
		_gateAccess = false;
		keyValid = false;
		cutText ["You no longer have gate access, type code in again to have access", "PLAIN DOWN"];
		};
	sleep .1;
	};
	keyValid = false;
};
if (!_validMatch) then {
	cutText ["!!! ACCESS DENIED !!!", "PLAIN DOWN"];
	//_soundSource = createSoundSource ["beep", position _panel, [], 25];
	playsound "beep";
	//[_panel,"beep",0,false] call dayz_zombieSpeak;
	sleep 2;
	cutText ["Wrong code was entered", "PLAIN DOWN"];
};

CODEINPUT = [];

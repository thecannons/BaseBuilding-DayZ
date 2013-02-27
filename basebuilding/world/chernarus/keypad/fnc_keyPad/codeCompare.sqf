private ["_soundSource","_panel","_convertInput","_code", "_inputCode", "_validMatch"];
_panel = cursortarget;
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
	sleep 2;
	cutText ["You can now operate the bases gate panel(s) for 15 seconds", "PLAIN DOWN"];
	sleep 15;
	keyValid = false;
	cutText ["You no longer have gate access, type code in again to have access", "PLAIN DOWN"];
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

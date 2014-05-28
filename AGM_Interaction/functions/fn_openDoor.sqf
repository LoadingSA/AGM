// by commy2

#define MAX_DISTANCE 2
#define DOOR_TYPES ["door", "hatch"]

_position0 = positionCameraToWorld [0, 0, 0];
_position1 = positionCameraToWorld [0, 0, MAX_DISTANCE];

_intersections = lineIntersectsWith [ATLToASL _position0, ATLToASL _position1, player, objNull, true];

_count = count _intersections;

if (_count == 0) exitWith {};

_house = _intersections select (_count - 1);

_intersections = [_house, "GEOM"] intersect [_position0, _position1];

_door = "";
{
	_selection = toArray (_x select 0);

	_index = _selection find 95;

	if (_index != -1) then {
		_selection resize _index;

		if (toString _selection in DOOR_TYPES) then {
			_door = _x select 0;
		};
	};
} forEach _intersections;

if (_door == "") exitWith {};

_animation = _door + "_rot";

AGM_Interaction_isOpeningDoor = true;

/*
[_house, _animation] spawn {
	_house = _this select 0;
	_animation = _this select 1;
	_increment = [-0.1, 0.1] select (_house animationPhase _animation < 0.5);

	while {AGM_Interaction_isOpeningDoor} do {
		_phase = (_house animationPhase _animation) + _increment;
		_house animate [_animation, _phase];
		waitUntil {_house animationPhase _animation == _phase || {!AGM_Interaction_isOpeningDoor}};
	};
};
*/

_phase = [0, 1] select (_house animationPhase _animation < 0.5);
_house animate [_animation, _phase];

/**
 * SecondaryWeapons_events_onKilled
 *
 * Dual Arms Mod
 * Contact: Andrew#0693 on Discord
 * © 2018 Andrew_S90
 *
 * This mod may be used in private repos for units but reuploads on steam/armaholic/playwithsix are not allowed.
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
 */
 
private ["_victim", "_info", "_magazines", "_weaponsItems", "_newPrimary", "_isOnFoot", "_weaponHolder", "_magClassName", "_magAmmo"];

_victim = _this select 0;
if (isNull _victim) exitWith {};

_victim removeAction SecondaryWeaponsAddSecondary;
_victim removeAction SecondaryWeaponsSwapPrimary;

_info = ["",[],[],[]];
_info set [0, (secondaryWeapon _victim)];

if(((_info select 0) != "") && {((_info select 0) splitString "_") select ((count ((_info select 0) splitString "_"))-1) == "secondary"}) then
{
	_info set [1, (secondaryWeaponItems _victim)];
	_magazines = getArray(configFile >> "cfgWeapons" >> (secondaryWeapon _victim) >> "magazines");
	{
		_magazines set [_forEachIndex, toLower _x]; 
	} forEach _magazines;

	_weaponsItems = weaponsItems _victim;
	{
		if(secondaryWeapon _victim == (_x select 0)) exitWith 
		{
			_weaponsItems = _x;
		};
	} forEach _weaponsItems;

	{
		if(typeName _x isEqualTo "ARRAY") then 
		{
			if(toLower (_x select 0) in _magazines) then
			{
				_info set [2, [toLower (_x select 0), (_x select 1)]];
			}
			else
			{
				_info set [3, [toLower (_x select 0), (_x select 1)]];
			};
		};
	} forEach _weaponsItems;

	_victim removeWeapon (_info select 0);
	_newPrimary = [(_info select 0), 0, -10] call BIS_fnc_trimString;
	
	if(SecondaryWeaponsDropOnDeath) then
	{
		_isOnFoot = isNull objectParent _victim;
		if(_isOnFoot) then 
		{
			_weaponHolder = createVehicle ["GroundWeaponHolder", getPosATL _victim, [], 0, "CAN_COLLIDE"];
		} else {
			_weaponHolder = objectParent _victim;
		};
		
		_weaponHolder addWeaponCargoGlobal [_newPrimary,1];

		{
			_weaponHolder addItemCargoGlobal [([_x, 0, -10] call BIS_fnc_trimString),1];
		} forEach (_info select 1);

		if(count SecondaryWeaponsWeaponInfo > 0 && !((SecondaryWeaponsWeaponInfo select 0) isEqualTo "ARRAY")) then
		{
			{
				if(typeName _x isEqualTo "ARRAY") then
				{
					_weaponHolder addMagazineAmmoCargo [_x select 0, 1, _x select 1];
				} else {
					_weaponHolder addItemCargoGlobal [([_x, 0, -10] call BIS_fnc_trimString),1];
				};
			} forEach SecondaryWeaponsWeaponInfo;
		};
		
		if(count (_info select 2) > 0) then
		{
			_magClassName = [((_info select 2) select 0), 0, -10] call BIS_fnc_trimString;
			_magAmmo = ((_info select 2) select 1);
			
			_weaponHolder addMagazineAmmoCargo [_magClassName, 1, _magAmmo];
		};
	};
};
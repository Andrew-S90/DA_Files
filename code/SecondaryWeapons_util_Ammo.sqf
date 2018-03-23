/**
 * SecondaryWeapons_util_Ammo
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

private ["_info", "_magazines", "_weaponsItems"];

_info = [[],[],[]];
if(_this) then
{
	_info set [0, (primaryWeaponItems player)];
	_magazines = getArray(configFile >> "cfgWeapons" >> (primaryWeapon player) >> "magazines");
	{
		_magazines set [_forEachIndex, toLower _x]; 
	} forEach _magazines;
	
	_weaponsItems = weaponsItems player;
	{
		if(primaryWeapon player == (_x select 0)) exitWith 
		{
			_weaponsItems = _x;
		};
	} forEach _weaponsItems;
	
	{
		if(typeName _x == "ARRAY") then 
		{
			if(toLower (_x select 0) in _magazines) then
			{
				_info set [1, [toLower (_x select 0), (_x select 1)]];
			}
			else
			{
				_info set [2, [toLower (_x select 0), (_x select 1)]];
			};
		};
	} forEach _weaponsItems;
} 
else 
{
	_info set [0, (secondaryWeaponItems player)];
	_magazines = getArray(configFile >> "cfgWeapons" >> (secondaryWeapon player) >> "magazines");
	{
		_magazines set [_forEachIndex, toLower _x]; 
	} forEach _magazines;
	
	_weaponsItems = weaponsItems player;
	{
		if(secondaryWeapon player == (_x select 0)) exitWith 
		{
			_weaponsItems = _x;
		};
	} forEach _weaponsItems;
	
	{
		if(typeName _x == "ARRAY") then 
		{
			if(toLower (_x select 0) in _magazines) then
			{
				_info set [1, [toLower (_x select 0), (_x select 1)]];
			}
			else
			{
				_info set [2, [toLower (_x select 0), (_x select 1)]];
			};
		};
	} forEach _weaponsItems;
	
	SecondaryWeaponsTakeFix = [_info select 0,_info select 1];
};
_info
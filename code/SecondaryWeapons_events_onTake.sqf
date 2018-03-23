/**
 * SecondaryWeapons_events_onTake
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
 
private ["_dialog", "_buttonDown", "_params", "_containerObj", "_launcherinfo", "_cargo", "_weapon", "_muz", "_point", "_op", "_mag", "_magGL", "_bipod", "_attachments", "_magClassName", "_magGLClassName", "_magAmmo", "_magGLAmmo"];
_params = _this;

_containerObj = (_params select 1);

disableSerialization;

_dialog = uiNameSpace getVariable ["RscDisplayInventory", displayNull];
if (!(_dialog isEqualTo displayNull)) then
{
	_buttonDown = _dialog displayCtrl 1337;
	_buttonDown ctrlEnable (primaryWeapon player != "");
	_buttonDown ctrlCommit 0;
};

if((SecondaryWeaponsClassName != "") && {(getNumber (configFile >> "CfgWeapons" >> (_params select 2) >> "Type") == 4)}) then 
{

	_launcherinfo = weaponsItems player;

	player removeWeapon (_params select 2);
	
	player addWeapon SecondaryWeaponsClassName;
	
	if(count (SecondaryWeaponsTakeFix select 0) > 0) then
	{
		{
			if(_x != "") then 
			{
				player addSecondaryWeaponItem _x;		
			};
		} forEach (SecondaryWeaponsTakeFix select 0);
	};
	
	if(count (SecondaryWeaponsTakeFix select 1) > 0) then
	{
		player addWeaponItem [SecondaryWeaponsClassName, [((SecondaryWeaponsTakeFix select 1) select 0), ((SecondaryWeaponsTakeFix select 1) select 1)]];
	};
	
	{
		if((_params select 2) == (_x select 0)) exitWith 
		{
			_launcherinfo = _x;
		};
		
	} forEach _launcherinfo;
	
	_cargo = weaponsItemsCargo _containerObj;
	clearWeaponCargoGlobal _containerObj;
	
	_cargo pushBack _launcherinfo;
	
	
	{
		_weapon = (_x select 0);
		_muz = (_x select 1);
		_point = (_x select 2);
		_op = (_x select 3);
		_mag = (_x select 4);
		_magGL = (_x select 5);
		_bipod = (_x select 6);
		
		if (count _x < 7) then 
		{
			_bipod = _magGL;
			_magGL = "";
		};
		if((toLower SecondaryWeaponsClassName) != (toLower _weapon)) then
		{
			_containerObj addWeaponCargoGlobal [_weapon, 1];
			
			if(!(toLower _weapon in ["exile_melee_axe","exile_melee_shovel","exile_melee_sledgehammer"])) then
			{
			
				_attachments = [];
				{
					_attachments pushBack toLower getText (_x >> "item");
				} forEach ("true" configClasses (configfile >> "CfgWeapons" >> _weapon >> "LinkedItems"));
				
				if !(toLower _muz in _attachments) then 
				{
					_containerObj addItemCargoGlobal [_muz, 1];
				};
				if !(toLower _point in _attachments) then 
				{
					_containerObj addItemCargoGlobal [_point, 1];
				};
				if !(toLower _op in _attachments) then 
				{
					_containerObj addItemCargoGlobal [_op, 1];
				};
				if !(toLower _bipod in _attachments) then 
				{
					_containerObj addItemCargoGlobal [_bipod, 1];
				};

				_magClassName = "";
				_magGLClassName = "";
				_magAmmo = 0;
				_magGLAmmo = 0;
				if(count _mag > 0) then 
				{
					_magClassName = (_mag select 0);
					_magAmmo = (_mag select 1);
				};
				
				
				if (_magClassName != "") then 
				{
					if((getNumber (configFile >> "CfgWeapons" >> _weapon >> "Type") == 4)) then
					{
						_containerObj addMagazineCargoGlobal [_magClassName,_magAmmo];
					} else {
						_containerObj addMagazineAmmoCargo [_magClassName, 1, _magAmmo];
					};	
				};
				
				if(count _magGL > 0) then 
				{
					_magGLClassName = (_magGL select 0);
					_magGLAmmo = (_magGL select 1);
				};
				
				if (_magGLClassName != "") then 
				{
					_containerObj addMagazineAmmoCargo [_magGLClassName, 1, _magGLAmmo];
				};
			};
		};
	} forEach _cargo;
	
	systemchat "Remove your Secondary Weapon to enable launchers!";
};
true
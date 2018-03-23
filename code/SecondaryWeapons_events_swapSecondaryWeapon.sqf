/**
 * SecondaryWeapons_events_swapSecondaryWeapon
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
private ["_buttonDown", "_weapon", "_secondaryWeapon", "_oldWeapon", "_error", "_weaponsItems", "_oldWeaponItems", "_primInfo", "_secInfo", "_newPrimary", "_magClassName", "_magAmmo", "_add2Weapon", "_currentAmmo", "_magGLClassName", "_magGLAmmo", "_loadGLammo", "_muzzles", "_dialog", "_BG", "_slot", "_buttonUp", "_cover", "_pic", "_icoB", "_ico", "_SecondaryWeaponItems"];

_weapon = _this;
_secondaryWeapon = "";
_oldWeapon = "";
_error = false;

_weaponsItems = [];
_oldWeaponItems = [];
_primInfo = [];
_secInfo = [];

_secondaryWeapon = format["%1%2",_weapon,"_secondary"];
disableSerialization;


if((_weapon != "") && !(isClass (configFile >> "CfgWeapons" >> _secondaryWeapon))) exitWith { systemchat "The Weapon you are trying to put on your back is currently unsupported. Please post on the workshop to get support for your mod.";};

if(toLower _weapon in SecondaryWeaponsBlockedWeapons) exitWith { systemchat "That current weapon is not able to fit on your back!"; };
if(SecondaryWeaponsSwapping) exitWith {};

SecondaryWeaponsSwapping = true;
if (_weapon != "") then 
{
	player action["switchWeapon", player, player, 100];
	uiSleep 1.5;
	
	_weaponsItems = true call SecondaryWeapons_util_Ammo;
	
	if((primaryWeapon player) == "") exitWith {_error = true;};
	player removeWeapon _weapon;
	
	_oldWeaponItems = false call SecondaryWeapons_util_Ammo;
	_oldWeapon = SecondaryWeaponsClassName;
	_secInfo = SecondaryWeaponsWeaponInfo;
	
	SecondaryWeaponsClassName = _secondaryWeapon;
	SecondaryWeaponsWeaponInfo = [];
} 
else 
{
	_oldWeaponItems = false call SecondaryWeapons_util_Ammo;
	_oldWeapon = SecondaryWeaponsClassName;
	_secInfo = SecondaryWeaponsWeaponInfo;
	
	SecondaryWeaponsClassName = "";
	SecondaryWeaponsWeaponInfo = [];
	SecondaryWeaponsTakeFix = [[],[]];
};

if(_error) exitWith {SecondaryWeaponsSwapping = false;};

player removeWeapon _oldWeapon;

_newPrimary = [_oldWeapon, 0, -10] call BIS_fnc_trimString;

player addWeapon _newPrimary;

{
	player addPrimaryWeaponItem ([_x, 0, -10] call BIS_fnc_trimString);
} forEach (_oldWeaponItems select 0);

if(count _secInfo > 0 && !((_secInfo select 0) isEqualTo "ARRAY")) then
{
	player addPrimaryWeaponItem ([(_secInfo select 0), 0, -10] call BIS_fnc_trimString);
};

if(count (_oldWeaponItems select 1) > 0) then
{
	_magClassName = [((_oldWeaponItems select 1) select 0), 0, -10] call BIS_fnc_trimString;
	_magAmmo = ((_oldWeaponItems select 1) select 1);

	if (_magClassName != "") then 
	{
		if(count primaryWeaponMagazine player > 0) then
		{
			_add2Weapon = true;
			{
				_currentAmmo = _x;
				{
					if(toLower _x isEqualto toLower _currentAmmo) then
					{
						_add2Weapon = false;
					};	
				} forEach getArray(configFile >> "cfgWeapons" >> _newPrimary >> "magazines");
			} forEach primaryWeaponMagazine player;	
			
			if(_add2Weapon) then
			{
				player addWeaponItem [_newPrimary, [_magClassName, _magAmmo]];
			}
			else
			{
				player addMagazine [_magClassName, _magAmmo];
			};
		}
		else
		{
			player addWeaponItem [_newPrimary, [_magClassName, _magAmmo]];
		};		
	};
};
	
{
	if(typeName _x isEqualTo "ARRAY") then
	{
		_magGLClassName = (_x select 0);
		_magGLAmmo = (_x select 1);
		if(count primaryWeaponMagazine player > 0) then
		{
			_loadGLammo = false;
			if(count primaryWeaponMagazine player isEqualTo 2) then
			{
				player addMagazine [_magGLClassName, _magGLAmmo];
			}
			else
			{
				{
					if(toLower _x isEqualto toLower ((primaryWeaponMagazine player) select 0)) then
					{
						_loadGLammo = true;
					};	
				} forEach getArray(configFile >> "cfgWeapons" >> _newPrimary >> "magazines");
				
				if(_loadGLammo) then
				{
					player addWeaponItem [_newPrimary, [_magGLClassName, _magGLAmmo]];
				}
				else
				{
					player addMagazine [_magGLClassName, _magGLAmmo];
				};
			};
		}
		else
		{
			player addWeaponItem [_newPrimary, [_magGLClassName, _magGLAmmo]];
		};
	};
} forEach _secInfo;

uisleep 0.5;
_muzzles = getArray(configFile >> "cfgWeapons" >> _newPrimary >> "muzzles");
	 
if (count _muzzles > 1) then
{
	player selectWeapon (_muzzles select 0);
}
else
{
	player selectWeapon _newPrimary;
};

if(_weapon != "") then
{
	player addWeapon SecondaryWeaponsClassName;
	
	{
		if(_x != "") then 
		{
			if(toLower format["%1_secondary",_x] in getArray(configFile >> "cfgWeapons" >> SecondaryWeaponsClassName >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems")) then
			{
				SecondaryWeaponsWeaponInfo pushBack (toLower format["%1_secondary",_x]);
			}
			else
			{
				player addSecondaryWeaponItem format["%1_secondary",_x];		
			};
		};
	} forEach (_weaponsItems select 0);

	if(count (_weaponsItems select 1) > 0) then
	{
		player addWeaponItem [SecondaryWeaponsClassName, [format["%1_secondary",((_weaponsItems select 1) select 0)], ((_weaponsItems select 1) select 1)]];
	};

	if(count (_weaponsItems select 2) > 0) then
	{
		SecondaryWeaponsWeaponInfo pushBack [toLower ((_weaponsItems select 2) select 0), ((_weaponsItems select 2) select 1)];
	};
	player setVariable ["SecondaryWeaponsWeaponInfo", SecondaryWeaponsWeaponInfo,true];
	false call SecondaryWeapons_util_Ammo;
};

_dialog = uiNameSpace getVariable ["RscDisplayInventory", displayNull];
if (!(_dialog isEqualTo displayNull)) then
{
	_BG = _dialog displayCtrl 1247;
	_slot = _dialog displayCtrl 611;
	_buttonUp = _dialog displayCtrl 6969;
	_buttonUp ctrlEnable (SecondaryWeaponsClassName != "");
	_buttonUp ctrlCommit 0;
	
	_buttonDown = _dialog displayCtrl 1337;
	_buttonDown ctrlEnable (primaryWeapon player != "");
	_buttonDown ctrlCommit 0;
	
	
	_pos = ctrlPosition _slot;

	if(_weapon != "") then 
	{
		"destroy" call SecondaryWeapons_gui_muzzleSlot;
		"destroy" call SecondaryWeapons_gui_accSlot;
		"destroy" call SecondaryWeapons_gui_opticSlot;
		"destroy" call SecondaryWeapons_gui_underSlot;
		"destroy" call SecondaryWeapons_gui_magazineSlot;
		_cover = _dialog displayCtrl 1530;
		if!(isNull _cover) then 
		{
			_cover ctrlSetPosition SecondaryWeaponsInventoryPosition;
			_cover ctrlSetBackgroundColor [0.7,0.7,0.7,0.1];
			_cover ctrlCommit 0;
		} else {
			_cover = _dialog ctrlCreate ["RscText", 1530];
			_cover ctrlSetPosition SecondaryWeaponsInventoryPosition;
			_cover ctrlSetBackgroundColor [0.7,0.7,0.7,0.1];
			_cover ctrlCommit 0;
		};	


		_pic = _dialog displayCtrl 1531;
		if!(isNull _pic) then 
		{
			_pic ctrlSetPosition SecondaryWeaponsInventoryPosition;
			_pic ctrlSetText (getText(configFile >> "cfgWeapons" >> _secondaryWeapon >> "img"));
			_pic ctrlCommit 0;	
		} else {
			_pic = _dialog ctrlCreate ["RscPictureKeepAspect", 1531];
			_pic ctrlSetPosition SecondaryWeaponsInventoryPosition;
			_pic ctrlSetText (getText(configFile >> "cfgWeapons" >> _secondaryWeapon >> "img"));
			_pic ctrlCommit 0;
		};	
		   
		{
			_x ctrlSetPosition [0,0,0,0];
			_x ctrlSetScale 0;
			_x ctrlCommit 0;
		} forEach [_slot,_BG];
		
		{
			(_dialog displayCtrl (_x select 1)) ctrlSetPosition [0,0,0,0];
			(_dialog displayCtrl (_x select 1)) ctrlSetScale 0;
			(_dialog displayCtrl (_x select 1)) ctrlCommit 0;
			
			(_dialog displayCtrl (_x select 2)) ctrlSetPosition [0,0,0,0];
			(_dialog displayCtrl (_x select 2)) ctrlSetScale 0;
			(_dialog displayCtrl (_x select 2)) ctrlCommit 0;
			
			_icoB = _dialog ctrlCreate ["RscText", ((_x select 1)*4)];

			_icoB ctrlSetPosition (_x select 0);
			_icoB ctrlSetBackgroundColor [0.7,0.7,0.7,0.1];
			_icoB ctrlCommit 0;
			
			_ico = _dialog ctrlCreate ["RscPictureKeepAspect", ((_x select 2)*4)];

			_ico ctrlSetPosition (_x select 0);
			_ico ctrlSetText (_x select 4);
			_ico ctrlCommit 0;
			
		} forEach [SecondaryWeaponsAccSlotInfo,SecondaryWeaponsMagazineSlotInfo,SecondaryWeaponsMuzzleSlotInfo,SecondaryWeaponsOpticSlotInfo,SecondaryWeaponsUnderSlotInfo];

		_SecondaryWeaponItems = false call SecondaryWeapons_util_Ammo;
		

		if(((_SecondaryWeaponItems select 0) select 1) != "") then
		{
			((_SecondaryWeaponItems select 0) select 1) call SecondaryWeapons_gui_muzzleSlot;
		};
		
		if(count SecondaryWeaponsWeaponInfo > 0 && !((SecondaryWeaponsWeaponInfo select 0) isEqualTo "ARRAY")) then
		{
			(SecondaryWeaponsWeaponInfo select 0) call SecondaryWeapons_gui_accSlot;
		};
		
		if(((_SecondaryWeaponItems select 0) select 2) != "") then
		{
			((_SecondaryWeaponItems select 0) select 2) call SecondaryWeapons_gui_opticSlot;
		};
		
		if(((_SecondaryWeaponItems select 0) select 3) != "") then
		{
			((_SecondaryWeaponItems select 0) select 3) call SecondaryWeapons_gui_underSlot;
		};
		
		if(count (_SecondaryWeaponItems select 1) > 0) then
		{
			(_SecondaryWeaponItems select 1) call SecondaryWeapons_gui_magazineSlot;
		};

	} else {

		_cover = _dialog displayCtrl 1530;
		if!(isNull _cover) then 
		{
			_pos = ctrlPosition _cover;
			ctrlDelete _cover;

			_slot ctrlSetPosition _pos;
			_slot ctrlSetScale 1;
			_slot ctrlCommit 0;
				
			_BG ctrlSetPosition _pos;
			_BG ctrlSetScale 1;
			_BG ctrlCommit 0;
		} else {
			//Somehow this was possible??
			_slot ctrlSetPosition SecondaryWeaponsInventoryPosition;
			_slot ctrlSetScale 1;
			_slot ctrlCommit 0;
				
			_BG ctrlSetPosition SecondaryWeaponsInventoryPosition;
			_BG ctrlSetScale 1;
			_BG ctrlCommit 0;
		};
		
		"destroy" call SecondaryWeapons_gui_muzzleSlot;
		"destroy" call SecondaryWeapons_gui_accSlot;
		"destroy" call SecondaryWeapons_gui_opticSlot;
		"destroy" call SecondaryWeapons_gui_underSlot;
		"destroy" call SecondaryWeapons_gui_magazineSlot;

		_pic = _dialog displayCtrl 1531;
		if!(isNull _pic) then 
		{
			ctrlDelete _pic;
		};
	};
};

if(SecondaryWeaponsAddAction) then
{
	player setUserActionText [SecondaryWeaponsSwapPrimary, format["Swap to Weapon %1", getText (configFile >> "CfgWeapons" >> (secondaryWeapon player) >> "displayName")]];
	player setUserActionText [SecondaryWeaponsAddSecondary, format["Put Weapon %1 on back", getText (configFile >> "CfgWeapons" >> (primaryWeapon player) >> "displayName")]];
};

SecondaryWeaponsSwapping = false;
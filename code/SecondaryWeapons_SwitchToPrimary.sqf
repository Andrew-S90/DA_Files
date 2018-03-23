/**
 * SecondaryWeapons_SwitchToPrimary
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

if (primaryWeapon player != "") then
{
	if (primaryWeapon player != currentWeapon player) then
	{
		player selectWeapon (primaryWeapon player);
	};
};
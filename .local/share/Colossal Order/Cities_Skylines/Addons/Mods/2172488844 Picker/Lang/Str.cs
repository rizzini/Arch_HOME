namespace Picker.Lang
{
	public class Str
	{
		public static System.Globalization.CultureInfo Culture {get; set;}
		public static QCommonLib.Lang.LocalizeManager LocaleManager {get;} = new QCommonLib.Lang.LocalizeManager("Str", typeof(Str).Assembly);

		/// <summary>
		/// Reset Button Position
		/// </summary>
		public static string options_ResetButtonPosition => LocaleManager.GetString("options_ResetButtonPosition", Culture);

		/// <summary>
		/// Set ground/elevated/etc mode in Network Anarchy or Fine Road Tool
		/// </summary>
		public static string options_SetFRTMode => LocaleManager.GetString("options_SetFRTMode", Culture);

		/// <summary>
		/// If Network Anarchy or FRT is enabled, should Picker set Ground/Elevated/etc to match picked segment?
		/// </summary>
		public static string options_SetFRTMode_Tooltip => LocaleManager.GetString("options_SetFRTMode_Tooltip", Culture);

		/// <summary>
		/// Open picked item in menu
		/// </summary>
		public static string options_OpenMenu => LocaleManager.GetString("options_OpenMenu", Culture);

		/// <summary>
		/// Should the menu (including Find It) open?
		/// </summary>
		public static string options_OpenMenu_Tooltip => LocaleManager.GetString("options_OpenMenu_Tooltip", Culture);

		/// <summary>
		/// Not found
		/// </summary>
		public static string options_NotFound => LocaleManager.GetString("options_NotFound", Culture);

		/// <summary>
		/// Found
		/// </summary>
		public static string options_Found => LocaleManager.GetString("options_Found", Culture);

		/// <summary>
		/// Unknown
		/// </summary>
		public static string options_Unknown => LocaleManager.GetString("options_Unknown", Culture);

		/// <summary>
		/// Eyedrop any object from the map, by Elektrix and Quboid
		/// </summary>
		public static string mod_Description => LocaleManager.GetString("mod_Description", Culture);

		/// <summary>
		/// Toggle Tool
		/// </summary>
		public static string keybind_ToggleTool => LocaleManager.GetString("keybind_ToggleTool", Culture);

		/// <summary>
		/// Only for networks
		/// </summary>
		public static string options_OpenMenuNetworks => LocaleManager.GetString("options_OpenMenuNetworks", Culture);

		/// <summary>
		/// Use UnifiedUI
		/// </summary>
		public static string options_UseUUI => LocaleManager.GetString("options_UseUUI", Culture);

		/// <summary>
		/// Press Any Key
		/// </summary>
		public static string key_pressAnyKey => LocaleManager.GetString("key_pressAnyKey", Culture);

		/// <summary>
		/// Align Icons Vertically
		/// </summary>
		public static string options_VerticalIcons => LocaleManager.GetString("options_VerticalIcons", Culture);

		/// <summary>
		/// Large
		/// </summary>
		public static string options_IconsLarge => LocaleManager.GetString("options_IconsLarge", Culture);

		/// <summary>
		/// Medium
		/// </summary>
		public static string options_IconsMedium => LocaleManager.GetString("options_IconsMedium", Culture);

		/// <summary>
		/// Small
		/// </summary>
		public static string options_IconsSmall => LocaleManager.GetString("options_IconsSmall", Culture);

		/// <summary>
		/// Tiny
		/// </summary>
		public static string options_IconsTiny => LocaleManager.GetString("options_IconsTiny", Culture);

		/// <summary>
		/// Size of icons on Recent Items list
		/// </summary>
		public static string options_IconsLabel => LocaleManager.GetString("options_IconsLabel", Culture);
	}
}
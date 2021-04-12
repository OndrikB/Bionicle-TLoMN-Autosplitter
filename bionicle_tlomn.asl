//This is an autosplitter for Bionicle: The Legend of Mata Nui. 
//Huge thanks to marczeslaw for finding one of the most important addresses here, and for teaching me how pointerscan works. 
//More things are planned

state("LEGO Bionicle")
{
	//int conv_test : "LEGO Bionicle.exe", 0x3B507C;
	string255 dfarea : "LEGO Bionicle.exe", 0x43AF00;
	int pickup : "LEGO Bionicle.exe", 0x312D8C; //works yay
	string4 nareaID : "LEGO Bionicle.exe", 0x347490;
	int Load : "LEGO Bionicle.exe", 0x309AE8; //actually with the fade to black
	byte level : "LEGO Bionicle.exe", 0x34748C;
	string4 pickupname : "LEGO Bionicle.exe", 0x00425B50, 0x3BC, 0x634, 0xF4, 0x7EC, 0x3B4; //finally jeez - updated version
	int load_cin : "LEGO Bionicle.exe", 0x0043AA8C, 0x164, 0x2A8, 0x38, 0x184, 0x84;
	int conv : "LEGO Bionicle.exe", 0x0043AA84, 0x160, 0x4C, 0x4, 0xCC, 0x68C;
	int paused : "LEGO Bionicle.exe", 0x3032C4;
}

init
{
    timer.IsGameTimePaused = false;
    vars.area = "";
}

startup {
	settings.Add("sgTiming", false, "Segmented timing (not allowed in runs)");
	settings.Add("areaChangeSplit", false, "Split every time you change areas (not recommended)");
	settings.Add("levelChangeSplit", true, "Split every time the level changes");
	settings.Add("pickUpSplits", true, "Split every time you pick up an item"); //todo: choice
	settings.Add("brushmode", false, "Boss rush mode"); //TODO: implement LULW (difficult due to boss health handling)
	//LEV1 splits
	settings.Add("l1Splits", false, "Level-1 Onua","pickUpSplits");
	settings.Add("hok1Split", true, "Split on picking up the grapple","l1Splits");
	settings.Add("ruruSplit", true, "Split on picking up the Ruru","l1Splits");
	settings.Add("hunaSplit", true, "Split on picking up the Huna","l1Splits");
	settings.Add("gly1Split", true, "Split on picking up the glyph","l1Splits");
	settings.Add("stn1Split", false, "Split on picking up the Makoki Stone","l1Splits");
	settings.Add("pgl1Split", false, "Split on picking up the printing glyph (Rebuilt-only)","l1Splits");
	settings.Add("q1Splits", false, "Splits for quests","l1Splits");
	settings.Add("q11sSplit", false, "Split on picking up the miner's pick","q1Splits");
	settings.Add("q11eSplit", false, "Split on picking up the first Amana Volo (Rebuilt-only)","q1Splits");
	settings.Add("q12sSplit", false, "Split on picking up Thali-Whali","q1Splits");
	settings.Add("q12eSplit", false, "Split on picking up the second Amana Volo (Rebuilt-only)","q1Splits");
	settings.Add("q13sSplit", false, "Split on picking up the throwing disk","q1Splits");
	settings.Add("q13eSplit", false, "Split on picking up the third Amana Volo (Rebuilt-only)","q1Splits");
	vars.L1Items = new Dictionary<string, string>()
	{
		{ "walc", "hok1Split" },
		{ "vksm", "ruruSplit" },
		{ "cksm", "hunaSplit" },
		{ "lylg", "gly1Split" },
		{ "nots", "stn1Split" },
		{ "1lgp", "pgl1Split" },
		{ "1cip", "q11sSplit" },
		{ "turf", "q11eSplit" },
		{ "gubb", "q12sSplit" },
		{ "1urf", "q12eSplit" },
		{ "csid", "q13sSplit" },
		{ "0urf", "q13eSplit" }
	};

	settings.Add("l2Splits", false, "Level-2 Gali","pickUpSplits");
	settings.Add("hok2Split", true, "Split on picking up the grapple","l2Splits");
	settings.Add("ms21Split", true, "Split on picking up the Rau","l2Splits");
	//settings.Add("ms22Split", true, "Split on picking up the Kaukau","l2Splits"); //Unavailable - item in water
	//settings.Add("gly2Split", true, "Split on picking up the glyph","l2Splits"); //Unavailable - item in water
	settings.Add("stn2Split", false, "Split on picking up the Makoki Stone","l2Splits");
	settings.Add("pgl2Split", false, "Split on picking up the printing glyph (Rebuilt-only)","l2Splits");
	settings.Add("q2Splits", false, "Splits for quests","l2Splits");
	//settings.Add("q21sSplit", false, "Split on picking up the gate stone","q2Splits"); //Unavailable - item in water (Rebuilt-only)
	settings.Add("q21eSplit", false, "Split on picking up the first Amana Volo (Rebuilt-only)","q2Splits");
	settings.Add("q22sSplit", false, "Split on picking up the gear","q2Splits");
	settings.Add("q22eSplit", false, "Split on picking up the second Amana Volo (Rebuilt-only)","q2Splits");
	settings.Add("q23sSplit", false, "Split on picking up the throwing disk","q2Splits");
	settings.Add("q23eSplit", false, "Split on picking up the third Amana Volo (Rebuilt-only)","q2Splits");
	vars.L2Items = new Dictionary<string, string>()
	{
		{ "kooh", "hok2Split" },
		{ "a9km", "ms21Split" },
		//{ "cksm", "ms22Split" }, //water
		//{ "lylg", "gly2Split" }, //water
		{ "nots", "stn2Split" },
		{ "2lgp", "pgl2Split" },
		//{ "ntsg", "q21sSplit" }, //water (in main it's on land)
		{ "1urf", "q21eSplit" },
		{ "raeg", "q22sSplit" },
		{ "0urf", "q22eSplit" },
		{ "2csd", "q23sSplit" },
		{ "turf", "q23eSplit" }
	};

	settings.Add("l3Splits", false, "Level-3 Pohatu","pickUpSplits");
	settings.Add("hok3Split", true, "Split on picking up the grapple","l3Splits");
	settings.Add("ms31Split", true, "Split on picking up the Komau","l3Splits");
	settings.Add("ms32Split", true, "Split on picking up the Kakama","l3Splits");
	settings.Add("gly3Split", true, "Split on picking up the glyph","l3Splits");
	settings.Add("stn3Split", false, "Split on picking up the Makoki Stone","l3Splits");
	settings.Add("pgl3Split", false, "Split on picking up the printing glyph (Rebuilt-only)","l3Splits");
	settings.Add("q3Splits", false, "Splits for quests","l3Splits");
	settings.Add("q31sSplit", false, "Split on picking up the ball","q3Splits");
	settings.Add("q31eSplit", false, "Split on picking up the first Amana Volo (Rebuilt-only)","q3Splits");
	settings.Add("q32sSplit", false, "Split on picking up the hammer","q3Splits");
	settings.Add("q32eSplit", false, "Split on picking up the second Amana Volo (Rebuilt-only)","q3Splits");
	settings.Add("q33sSplit", false, "Split on picking up the throwing disk","q3Splits");
	settings.Add("q33eSplit", false, "Split on picking up the third Amana Volo (Rebuilt-only)","q3Splits");
	vars.L3Items = new Dictionary<string, string>()
	{
		{ "kooh", "hok3Split" },
		{ "aksm", "ms31Split" },
		{ "sksm", "ms32Split" },
		{ "pylg", "gly3Split" },
		{ "nots", "stn3Split" },
		{ "3lgp", "pgl3Split" },
		{ "llbk", "q31sSplit" },
		{ "0urf", "q31eSplit" },
		{ "mmah", "q32sSplit" },
		{ "turf", "q32eSplit" },
		{ "3csd", "q33sSplit" },
		{ "1urf", "q33eSplit" }
	};

	settings.Add("l4Splits", false, "Level-4 Kopaka","pickUpSplits");
	settings.Add("hok4Split", true, "Split on picking up the grapple","l4Splits");
	settings.Add("ms41Split", true, "Split on picking up the Matatu","l4Splits");
	settings.Add("ms42Split", true, "Split on picking up the Akaku","l4Splits");
	settings.Add("gly4Split", true, "Split on picking up the glyph","l4Splits");
	settings.Add("stn4Split", false, "Split on picking up the Makoki Stone","l4Splits");
	settings.Add("pgl4Split", false, "Split on picking up the printing glyph (Rebuilt-only)","l4Splits");
	settings.Add("q4Splits", false, "Splits for quests","l4Splits");
	settings.Add("q41sSplit", false, "Split on picking up the ice skates","q4Splits");
	settings.Add("q41eSplit", false, "Split on picking up the first Amana Volo (Rebuilt-only)","q4Splits");
	settings.Add("q42sSplit", false, "Split on picking up the element of melting","q4Splits");
	settings.Add("q42eSplit", false, "Split on picking up the second Amana Volo (Rebuilt-only)","q4Splits");
	settings.Add("q43sSplit", false, "Split on picking up the throwing disk","q4Splits");
	settings.Add("q43eSplit", false, "Split on picking up the third Amana Volo (Rebuilt-only)","q4Splits");
	vars.L4Items = new Dictionary<string, string>()
	{
		{ "drws", "hok4Split" },
		{ "letm", "ms41Split" },
		{ "vksm", "ms42Split" },
		{ "aylg", "gly4Split" },
		{ "nots", "stn4Split" },
		{ "4lgp", "pgl4Split" },
		{ "stks", "q41sSplit" },
		{ "1urf", "q41eSplit" },
		{ "tsrc", "q42sSplit" },
		{ "0urf", "q42eSplit" },
		{ "csid", "q43sSplit" },
		{ "turf", "q43eSplit" }
	};

	settings.Add("l5Splits", false, "Level-5 Lewa","pickUpSplits");
	settings.Add("hok5Split", true, "Split on picking up the grapple","l5Splits");
	settings.Add("ms51Split", true, "Split on picking up the Mahiki","l5Splits");
	settings.Add("ms52Split", true, "Split on picking up the Miru","l5Splits");
	settings.Add("gly5Split", true, "Split on picking up the glyph","l5Splits");
	settings.Add("stn5Split", false, "Split on picking up the Makoki Stone","l5Splits");
	settings.Add("pgl5Split", false, "Split on picking up the printing glyph (Rebuilt-only)","l5Splits");
	settings.Add("q5Splits", false, "Splits for quests","l5Splits");
	settings.Add("q51sSplit", false, "Split on picking up the blue spider","q5Splits");
	settings.Add("q51eSplit", false, "Split on picking up the first Amana Volo (Rebuilt-only)","q5Splits");
	settings.Add("q52sSplit", false, "Split on picking up the Volo Lutu launcher","q5Splits");
	settings.Add("q52eSplit", false, "Split on picking up the second Amana Volo (Rebuilt-only)","q5Splits");
	settings.Add("q53sSplit", false, "Split on picking up the throwing disk","q5Splits");
	settings.Add("q53eSplit", false, "Split on picking up the third Amana Volo (Rebuilt-only)","q5Splits");
	vars.L5Items = new Dictionary<string, string>()
	{
		{ "1exa", "hok5Split" },
		{ "iksm", "ms51Split" },
		{ "ksam", "ms52Split" },
		{ "pylg", "gly5Split" },
		{ "nots", "stn5Split" },
		{ "5lgp", "pgl5Split" },
		{ "rdps", "q51sSplit" },
		{ "turf", "q51eSplit" },
		{ "ulov", "q52sSplit" },
		{ "0urf", "q52eSplit" },
		{ "5csd", "q53sSplit" },
		{ "1urf", "q53eSplit" }
	};

	settings.Add("l6Splits", false, "Level-6 Tahu","pickUpSplits");
	settings.Add("hok6Split", true, "Split on picking up the grapple","l6Splits");
	settings.Add("ms61Split", true, "Split on picking up the Hau","l6Splits");
	settings.Add("ms62Split", true, "Split on picking up the Vahi","l6Splits");
	settings.Add("gly6Split", true, "Split on picking up the glyph","l6Splits");
	settings.Add("stn6Split", false, "Split on picking up the Makoki Stone","l6Splits");
	settings.Add("pgl6Split", false, "Split on picking up the printing glyph","l6Splits");
	settings.Add("q6Splits", false, "Splits for quests","l6Splits");
	settings.Add("q61sSplit", false, "Split on picking up the Winch Lever","q6Splits");
	settings.Add("q61eSplit", false, "Split on picking up the first Amana Volo (Rebuilt-only)","q6Splits");
	settings.Add("q62sSplit", false, "Split on picking up the Lava Board","q6Splits");
	settings.Add("q62eSplit", false, "Split on picking up the second Amana Volo (Rebuilt-only)","q6Splits");
	settings.Add("q63sSplit", false, "Split on picking up the throwing disk","q6Splits");
	settings.Add("q63eSplit", false, "Split on picking up the third Amana Volo (Rebuilt-only)","q6Splits");
	vars.L6Items = new Dictionary<string, string>()
	{
		{ "drws", "hok6Split" },
		{ "a6km", "ms61Split" },
		{ "a5km", "ms62Split" },
		{ "pylg", "gly6Split" },
		{ "nots", "stn6Split" },
		{ "6lgp", "pgl6Split" },
		{ "rvel", "q61sSplit" },
		{ "turf", "q61eSplit" },
		{ "dels", "q62sSplit" },
		{ "1urf", "q62eSplit" },
		{ "6csd", "q63sSplit" },
		{ "0urf", "q63eSplit" }
	};



	vars.AllItems = new Dictionary<string, string>[]
	{
		vars.L1Items,
		vars.L2Items,
		vars.L3Items,
		vars.L4Items,
		vars.L5Items,
		vars.L6Items
	};

	//vars.bossAreas = new string[] {"BOSS", "MUD0", "HYDR", "MDMN", "RKMN", "ICMN", "WDMN", "DRGN"};
	vars.bossAreas = new string[] {"ssob", "0dum", "rdyh", "nmdm", "nmkr", "nmci", "nmdw", "ngrd"};
}


update
{
	if (current.dfarea.Length != 0) {
		vars.area = current.dfarea.Substring(current.dfarea.Length - 8, 4);
	}
}


isLoading {
	//return (current.Load == 1)  || (current.conv_test == 1) || (vars.area == "frnt");
	if (current.nareaID == "????") {
		return true;
	}
	if ((settings["sgTiming"]) && (current.paused == 1)) {
		return true;
	}
	if (settings["brushmode"]) {
		return (Array.IndexOf(vars.bossAreas, current.nareaID) == -1);
	}
	return ((current.load_cin == 1 && current.conv != 1) || (current.Load == 1)  || (current.nareaID == "tnrf") || (vars.area == "frnt"));
}


split {
	if ((settings["areaChangeSplit"]) && (current.nareaID != old.nareaID) && (old.nareaID != "tnrf") && (vars.area != "frnt")) {
		return true;
	}
	if ((settings["pickUpSplits"]) && (current.pickup == 1) && (old.pickup == 0)) {
		return settings[vars.AllItems[current.level-1][current.pickupname]];
	}
	if ((settings["levelChangeSplit"]) && (current.level != old.level) && (old.level != 0) && (vars.area != "frnt")) {
		return true;
	}
}

start {
	if ((current.level != old.level) && (old.level == 0)) {
		return true;
	}
}

exit
{
    timer.IsGameTimePaused = true;
}

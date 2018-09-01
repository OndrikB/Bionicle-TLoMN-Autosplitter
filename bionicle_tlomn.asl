state("LEGO Bionicle")
{
    bool HUD1 : "LEGO Bionicle.exe", 0x43AB2C;
    bool HUD2 : "LEGO Bionicle.exe", 0x34BBC8;
    uint areaID : "LEGO Bionicle.exe", 0x43AF55;
}
isLoading {
    return !current.HUD1 || !current.HUD2;
}
split {
    return current.areaID !=  old.areaID && old.areaID != 0;
}
start {
    return current.areaID != old.areaID && old.areaID == 0;
}

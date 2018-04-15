//Autosplitter for "Bionicle: The Legend of Mata Nui"
//Coded by benji
//Bugtested by OndrikB
state("LEGO Bionicle")
{
    uint LevelID : 0x0029B9B0;
    uint AreaID : 0x0029BDE4;
}

split
{
    if (old.AreaID != 0x3F3F3F3F && current.AreaID != old.AreaID)
    {
        print("SPLITTING!");
    }
    return old.AreaID != 0x3F3F3F3F && current.AreaID != old.AreaID;
}

start
{
    if (old.AreaID == 0x3F3F3F3F && current.AreaID != old.AreaID)
    {
        print("STARTING!");
    }
    return old.AreaID == 0x3F3F3F3F && current.AreaID != old.AreaID;
}

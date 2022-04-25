state("SELACO")
{
	int loading      : 0x109FCD0; 
    string50 mission : 0x11D8804;
}

startup
  {
    	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
// Asks user to change to game time if LiveSplit is currently set to Real Time.
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | SELACO",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );
        
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
  }

onStart
{
    // This is part of a "cycle fix", makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}

start
{
	return (old.loading != 0 && current.loading == 0 && current.mission.Contains("Invasion"));
}

split
{
    return current.mission != old.mission;
}

isLoading
{
	return current.loading != 0;
}

update
{ 
  // print(current.mission.ToString());  
} 
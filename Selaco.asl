state("SELACO")
{
  int loading       : 0x118B0D0; 
  int onNewCampaign : 0x7EF000;
}
//  string50 mission  : 0x11D8815; // Loaded level is stored as a string without UTF-16 - BUGGY AS FUCK DOESNT WORK LOL

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
    // This is a "cycle fix" that makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}

start
{
	return old.onNewCampaign == 0 && current.loading != 0;
}

isLoading
{
	return current.loading != 0;
}

update
{
 //print(current.onNewCampaign.ToString());
 //print(current.loading.ToString());
} 

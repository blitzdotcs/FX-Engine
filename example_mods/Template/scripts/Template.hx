// HScript stuff

function onCreate()
{
	// triggered when the hscript file is started, some variables weren't created yet
}

function onCreatePost()
{
	// end of "create"
}

function onDestroy()
{
	// triggered when the lua file is ended (Song fade out finished)
}


// Gameplay/Song interactions
function onSectionHit()
{
	// triggered after it goes to the next section
}

function onBeatHit()
{
	// triggered 4 times per section
}

function onStepHit()
{
	// triggered 16 times per section
}

function onUpdate(elapsed:Float)
{
	// start of "update", some variables weren't updated yet
}

function onUpdatePost(elapsed:Float)
{
	// end of "update"
}

function onStartCountdown()
{
	// countdown started, duh
	// return Function_Stop if you want to stop the countdown from happening (Can be used to trigger dialogues and stuff! You can trigger the countdown with startCountdown())
	return Function_Continue;
}

function onStartSong()
{
	// Inst and Vocals start playing, songPosition = 0
}

function onEndSong()
{
	// song ended/starting transition (Will be delayed if you're unlocking an achievement)
	// return Function_Stop to stop the song from ending for playing a cutscene or something.
	return Function_Continue;
}

function onCoolStartDeath()
{
	// You died! Called every single frame your health is lower (or equal to) zero
	// return Function_Stop if you want to stop the player from going into the game over screen
	return endBullshit;
}

function onEndBullshit(retry:Bool)
{
	// Called when you Press Enter/Esc on Game Over
	// If you've pressed Esc, value "retry" will be false
}

// Note miss/hit
function onGoodNoteHit(note:Note)
{
	// Function called when you hit a note (after note hit calculations)
}

function onNoteMissPress(direction:Int)
{
	// Called after the note press miss calculations
	// Player pressed a button, but there was no note to hit (ghost miss)
}

function onNoteMiss(note:Note)
{
	// Called after the note miss calculations
	// Player missed a note by letting it go offscreen
}


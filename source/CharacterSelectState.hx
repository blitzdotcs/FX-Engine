package;

import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;
import lime.utils.Assets;
import haxe.Json;
import Boyfriend.Boyfriend;
import Character.Character;
import flixel.ui.FlxBar;

typedef CharacterMenu = {
    var name:String;
    var characterName:String;
    var portrait:String;
}

class CharacterSelectState extends MusicBeatState
{
    var menuItems:Array<String> = ['bf', 'tauntbf', 'pico-player'];
    var curSelected:Int = 0;
    var txtDescription:FlxText;
    var shitCharacter:FlxSprite;
	var shitCharacterBetter:Boyfriend;
    var menuBG:FlxSprite;
    public var tagertY:Float = 0;
    var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;
    public static var characterShit:Array<CharacterMenu>;

    private var grpMenu:FlxTypedGroup<Alphabet>;
    private var grpMenuImage:FlxTypedGroup<FlxSprite>;
    var alreadySelected:Bool = false;
    var doesntExist:Bool = false;

    var names:Array<String> = 
    [
        "Boyfriend",
        "Tauntable BF! CREDITS TO THE NONSENSE MOD",
        "Pico's school fnf",    
        "Ugh guy also known as Pico's dad"    
    ];

    var txtOptionTitle:FlxText;

    override function create() 
    {
        menuBG = new FlxSprite().loadGraphic(Paths.image('BG4'));
        menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
        menuBG.updateHitbox();
        menuBG.screenCenter();
        menuBG.antialiasing = true;
        add(menuBG);

        grpMenu = new FlxTypedGroup<Alphabet>();
        add(grpMenu);

        grpMenuImage = new FlxTypedGroup<FlxSprite>();
        add(grpMenuImage);

        for (i in 0...menuItems.length)
        {
            var songText:Alphabet = new Alphabet(170, (70 * i) + 230, menuItems[i], true, false);
            songText.isMenuItem = true;
            songText.targetY = i;
            grpMenu.add(songText);
            //songText.x += 40;
            //DON'T PUT X IN THE FIRST PARAMETER OF new ALPHABET()!
            //songText.screenCenter(X);
        }

        txtDescription = new FlxText(FlxG.width * 0.075, menuBG.y + 200, 0, "", 32);
        txtDescription.alignment = CENTER;
        txtDescription.setFormat("assets/fonts/vcr.ttf", 32);
        txtDescription.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1.5, 1);
        txtDescription.color = FlxColor.WHITE;
        add(txtDescription);

        //shitCharacter = new FlxSprite(0, -20);
        //shitCharacter.scale.set(0.45, 0.45);
		//shitCharacter.updateHitbox();
		//shitCharacter.screenCenter(XY);
		//shitCharacter.antialiasing = true;
		//shitCharacter.y += 30;
		//add(shitCharacter);

        var charSelHeaderText:Alphabet = new Alphabet(0, 50, 'Character Select', true, false);
        charSelHeaderText.screenCenter(X);
        add(charSelHeaderText);

        txtOptionTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
        txtOptionTitle.setFormat("assets/fonts/vcr.ttf", 32, FlxColor.WHITE, RIGHT);
        txtOptionTitle.alpha = 0.7;
        add(txtOptionTitle);

        changeSelection();

        cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

        super.create();
    }

    override function update(elapsed:Float) 
    {
        txtOptionTitle.text = names[curSelected].toUpperCase();
        txtOptionTitle.x = FlxG.width - (txtOptionTitle.width +10);
        if (txtOptionTitle.text == '')
            {
                trace('');
                txtOptionTitle.text = '';
            }    

        var upP = controls.LEFT_P;
        var downP = controls.RIGHT_P;
        var accepted = controls.ACCEPT;

        if (!alreadySelected)
        {
            if (upP)
                {
                    changeSelection(-1);
                }

            if (downP)
                {
                    changeSelection(1);
                }

            if (accepted)
                {
                    alreadySelected = true;
                    var daSelected:String = menuItems[curSelected];
                    PlayState.hasPlayedOnce = true;
                    if (menuItems[curSelected] != 'bf')
                        PlayState.SONG.player1 = daSelected;

                    new FlxTimer().start(1, function(tmr:FlxTimer)
                        {
                            LoadingState.loadAndSwitchState(new PlayState());
                        });
                }
            
            if (controls.BACK)
                if (PlayState.isStoryMode)
                    FlxG.switchState(new StoryMenuState());
                else {
                    FlxG.switchState(new FreeplayState());
                }
        }

        super.update(elapsed);
    }

    function changeSelection(change:Int = 0):Void
        {
            curSelected += change;

            if (curSelected < 0)
                curSelected = menuItems.length - 1;
            if (curSelected >= menuItems.length)
                curSelected = 0;

            var otherInt:Int = 0;

            for (item in grpMenu.members)
                {
                    item.targetY = otherInt - curSelected;
                    otherInt++;

                    item.alpha = 0;
                    //item.setGraphicSize(Std.int(item.width * 0.8));

                    if (item.targetY == 0)
                        {
                            // item.setGraphicSize(Std.int(item.width));
                        }
                }
            
            charCheck();
        }

        function charCheck()
            {
                doesntExist = false;
                var daSelected:String = menuItems[curSelected];
                var storedColor:FlxColor = 0xFFFFFF;

                switch (daSelected)
                {
                    case "bf":
                        menuBG.loadGraphic('BG2');
                        menuBG.color = 0x87ceeb;
                    case "pico":
                        menuBG.loadGraphic('BG1');
				        menuBG.color = 0xFF00FF;	
                    default:
                        menuBG.loadGraphic('BG');
				        menuBG.color = 0xFFFFFF;
                }

                //shitCharacter.updateHitbox();
		        //shitCharacter.screenCenter(XY);

                doesntExist = true;

                var healthBarBG:FlxSprite = new FlxSprite(0, FlxG.height * 0.9).loadGraphic('assets/shared/images/healthBar.png');
                healthBarBG.screenCenter(X);
		        healthBarBG.scrollFactor.set();
		        healthBarBG.visible = false;
		        add(healthBarBG);

                var healthBar:FlxBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
                    'health', 0, 2);
                healthBar.scrollFactor.set();
                healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
                healthBar.visible = false;
                // healthBar
                add(healthBar);

            }
}
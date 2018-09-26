s.boot
s.scope

(
SynthDef(\sine,{
	arg freq = 440, amp = 1, noteOn = 0;
	var sig;
	sig = SinOsc.ar(freq, 0, amp) * noteOn;
	Out.ar(0, sig!2)
}).add
)

~sineSynth = Synth(\sine)
~sineSynth.set(\noteOn, 0)
~sineSynth.free
~freqModRange = 1200

(
var mainWindow, noteOnButton, theSlider, textBoxTheSliderX, textBoxTheSliderY,
rangeSlider, rangeSliderNumBoxMin, rangeSliderNumBoxMax;

//My main window
mainWindow = Window.new("SineControl", Rect(500, 500, 500, 200));
//Button to note On/Off
noteOnButton = Button.new(mainWindow, Rect(10, 10, 50, 25))
.states_([["OFF", Color.white, Color.black],["ON",Color.blue, Color.white]])
.action_({
	arg butt;
	~sineSynth.set(\noteOn, butt.value);
});
//NumberBox for the Slider
textBoxTheSliderX = NumberBox(mainWindow, Rect(70, 10, 40, 25))
.action_({
	arg boxx;
	//Assign the NumBox Value to the slider
	theSlider.activex_(boxx.value / ~freqModRange)
});
//NumBox for the slider
textBoxTheSliderY = NumberBox(mainWindow, Rect(120, 10, 40, 25))
.scroll_step_(0.05)
.action_({
	arg boxy;
	//assign the NumBox value to the slider
	theSlider.activey_(boxy.value);
});
//Slider to control the amp and the freq of the synth
theSlider = Slider2D(mainWindow, Rect(10, 45, 450, 100))
.action_({
	arg sl;
	//Use x/y values to controll the frequency/amp respectively
	~sineSynth.set(\freq, (sl.x * ~freqModRange), \amp, (sl.y));
	//Use freqModRange to multiply value x of the 2dSlider
	textBoxTheSliderX.value_(sl.x * ~freqModRange);
	textBoxTheSliderY.value_(sl.y)
});
rangeSlider = RangeSlider(mainWindow, Rect(50, 155, 370, 25))
.action_({
	arg rs;
	rangeSliderNumBoxMin.value_(rs.lo * ~freqModRange);
	rangeSliderNumBoxMax.value_(rs.hi * ~freqModRange);
});
rangeSliderNumBoxMin = NumberBox(mainWindow, Rect(10, 155, 40, 25))
.action_({
	arg nb;
	rangeSlider.activeLo_(nb.value);
});
rangeSliderNumBoxMax = NumberBox(mainWindow, Rect(420, 155, 40, 25))
.action_({
	arg nb;
	rangeSlider.activeHi_(nb.value)
});
mainWindow.front
)
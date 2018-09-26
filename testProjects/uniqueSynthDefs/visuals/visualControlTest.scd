s.boot
s.scope

(
SynthDef(\synth,{
	arg freq = 440, amp = 1, noteOn = 0, bus = 0;
	var sig;
	sig = SinOsc.ar(freq, 0, amp)*noteOn;
	Out.ar(bus,sig!2)
}).add
)

~synth = Synth(\synth)
~synth.free

~rangeMax = 10000;

(
var mainWindow, freqModRange, freqModRangeMinNumBox, freqModRangeMaxNumBox,
freqFineSlider, freqFineSliderNumBox, freqText, onOffButton, ampSlider,
ampSliderNumBox;
mainWindow = Window("secondTestForVisualController", scroll: true);

//Frequency Section

freqModRange = RangeSlider(mainWindow, Rect(10, 35, 40, 200))
.action_({
	arg rs;
	freqModRangeMinNumBox.value_(rs.hi * ~rangeMax);
	freqModRangeMaxNumBox.value_(rs.lo * ~rangeMax);
});

freqModRangeMinNumBox = NumberBox(mainWindow, Rect(10, 10, 40, 25))
.action_({
	arg nb;
	freqModRange.activeHi_(nb.value / ~rangeMax);
});

freqModRangeMaxNumBox = NumberBox(mainWindow, Rect(10, 235, 40, 25))
.action_({
	arg nb;
	freqModRange.activeLo_(nb.value / ~rangeMax);
});

freqFineSlider = Slider(mainWindow, Rect(65, 35, 40, 200))
.action_({
	arg sl;
	~synth.set(\freq, (
		(sl.value * freqModRange.range * ~rangeMax) + (freqModRange.lo * ~rangeMax)));
	freqFineSliderNumBox.value_(
		(sl.value * freqModRange.range * ~rangeMax) + (freqModRange.lo * ~rangeMax))
});

freqFineSliderNumBox = NumberBox(mainWindow, Rect(65, 10, 40, 25))
.action_({
	arg nb;
	freqFineSlider.valueAction_(nb.value / ~rangeMax);
});

freqText = StaticText(mainWindow, Rect(10, 265, 100, 25))
.string_("Frequency Control")
.align_(\center);
mainWindow.front;

//Amp Section

onOffButton = Button(mainWindow, Rect(115, 235, 40, 25)).states_([
	["OFF", Color.white, Color.black],
	["ON", Color.blue, Color.white]
])
.action_({
	arg butt;
	~synth.set(\noteOn, butt.value);
});

ampSlider = Slider(mainWindow, Rect(115, 35, 40, 200))
.action_({
	arg ls;
	~synth.set(\amp, ls.value);
	ampSliderNumBox.value_(ls.value)
});

ampSliderNumBox = NumberBox(mainWindow, Rect(115, 10, 40, 25))
.action_({
	arg nb;
	ampSlider.valueAction_(nb.value)
})
.scroll_step_(0.01);

)

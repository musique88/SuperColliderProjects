s.boot;
s.scope

(
SynthDef.new("bass", {
	arg freq = 440, amp = 0.2;
	var monoOut;
	monoOut = Saw.ar(freq, amp);
	Out.ar(0, [monoOut,monoOut]);
}).add
)

x = Synth.new("bass")
x.free
x.set("freq", ~sliderValue * 1000)

(
~window = Window.new("SuperCollider is the thing!").front;
~numberBox = NumberBox(~window, Rect(10, 120, 40, 20));
~slider = Slider(~window, Rect(10, 10, 40, 100));
~slider.action_({(~sliderValue = ~slider.value)})
)


~slider
~freqFinal
~slider.value
~sliderValue.object
~sliderString.postLn
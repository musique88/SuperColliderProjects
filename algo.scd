s.boot;
s.scope;
(
~mainClock = TempoClock(140/60);
~mainClock.permanent = 1
)
// SynthDefs
(
SynthDef(\algoKick,{
	arg noiseDur = 0.1, sineDur = 0.35, amp = 0.75, noiseAmp = 0.5;
	var sig, noiseEnv, sineAmpEnv, sineFreqEnv;
	noiseEnv = XLine.kr(1, 0.0001, noiseDur);
	sineAmpEnv = XLine.kr(1, 0.0001, sineDur, doneAction: 2);
	sineFreqEnv = XLine.kr(100, 10, sineDur - 0.05);
	sig = SinOsc.ar(sineFreqEnv, 0, sineAmpEnv);
	sig = sig + BrownNoise.ar(noiseEnv*noiseAmp);
	sig = sig * amp;
	Out.ar(0,sig!2)
}).add;

SynthDef(\algoSnare, {
	arg noiseDur = 0.3, sineDur = 0.35, amp = 0.5, noiseAmp = 0.75, noteOn = 1;
	var sig, noiseEnv, sineAmpEnv, sineFreqEnv;
	noiseEnv = XLine.kr(1, 0.0001, noiseDur);
	sineAmpEnv = XLine.kr(1, 0.0001, sineDur, doneAction: 2);
	sineFreqEnv = XLine.kr(400, 200, sineDur - 0.05);
	sig = SinOsc.ar(sineFreqEnv, 0, sineAmpEnv);
	sig = sig + WhiteNoise.ar(noiseEnv*noiseAmp);
	sig = sig * amp * noteOn;
	Out.ar(0,sig!2)
}).add;

SynthDef(\algoSynth,{
	arg freq = 440, amp = 0.7, duration = 1, filterFreqEnvStart = 2200, filterFreqEnvEnd = 10,
	volume = 1, rq = 1, filterDur = 1;
	var ampEnv, sig, filterFreqEnv;
	ampEnv = XLine.kr(1, 1, duration, doneAction: 0);
	sig = Saw.ar(freq, ampEnv) * amp;
	filterFreqEnv = XLine.kr(filterFreqEnvStart, filterFreqEnvEnd, filterDur);
	sig = BLowPass4.ar(sig, filterFreqEnv, rq);
	sig = sig * volume;
	Out.ar(0,sig!2)
}).add
)
Synth(\algoKick)
Synth(\algoSnare)
Synth(\algoSynth, [\volume, 0.1, \rq, 0.01, \duration, 1, \filterDur, 1])
// Pbinds

(
~algoKickPattern = Pbind(
	\instrument, \algoKick,
	\dur, 1,
	\amp, Pwhite(0.5, 1),
	\noiseAmp, Pwhite(0.25, 0.60),
	\noiseDur, Pwhite(0.05, 0.2)
).play(~mainClock, quant: 1)
)
~algoKickPattern.stop
~algoKickPattern.play

(
~algoSnarePattern = Pbind(
	\instrument, \algoSnare,
	\dur, 1,
	\amp, 0.50,
	\noteOn, Pseq([0, 1], inf)
).play(~mainClock, quant: 1)
)
~algoSnarePattern.stop

(
~algoSynthPattern = Pbind(
	\instrument, \algoSynth,
	\dur, 1/4,
	\volume, 1,
	\rq, 0.15,
	\filterFreqEnvStart, 1000,
	\filterFreqEnvEnd, 100,

).play(~mainClock, quant: 1)
)

~algoSynthPattern.stop
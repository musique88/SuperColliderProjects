(
SynthDef(\kick,{
    arg gain = 0.5, noiseGain = 0.5, startFreq = 100, endFreq = 10,
	freqDur = 0.3, ampDur = 0.35, noiseDur = 0.15, outBus = 0,
	sineGain = 1;
    var sig, envFreq, envAmp, noiseAmpEnv;
    envAmp = XLine.kr(1, 0.001, ampDur, doneAction: 2) * sineGain;
    envFreq = XLine.kr(startFreq, endFreq, freqDur);
	noiseAmpEnv = XLine.kr(1, 0.001, noiseDur);
	sig = SinOsc.ar(envFreq, 0, envAmp);
	sig = sig + {GrayNoise.ar() * noiseAmpEnv * noiseGain};
	sig = sig * gain;
	Out.ar(outBus, sig!2);
    }
).add
)

(
x = Synth(\kick, [
	\noiseDur, 0.1,
	\ampDur, 0.3,
	\freqDur, 0.35,
	\startFreq, 100,
	\endFreq, 10
])
)
x.free
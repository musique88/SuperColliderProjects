s.boot

(
SynthDef(\superSaw, {
	arg freqBase = 440, extention = 0.001, nbUnison = 3;
	var sig, array;
	array = Array(nbUnison);
	i = 0;
	while( i < nbUnison, {
		if(i % 2 == 0, {
			array[i] = (freqBase + (extention * i))
		},{
			array[i] = (freqBase - (extention * i))
		});
		i = i + 1;
	});
	i = 0;
	while((i < nbUnison), {
		array[i] = LFSaw.ar(array[i]) * 1/nbUnison;
		i = i + 1
	});
	sig = Mix.ar(array);
	Out.ar(0, sig!2);
}).add
)

////////////////////////////////////////////////////////////////////////////////////////////////////
// A mixture of a string-like synth and an organ synth that sound to me vaguely like a baroque orchestra

(play
{
	var strings, organ, signal, midi, mix;

	midi = Duty.kr(
		[Dseq([1, 1, 0.5, 1, 0.5], inf), 3], // Two channels, the second providing values at 1/3 the speed of the first
		0,
		[Dseq([54, 61, 58, 59, 61, 66], inf), Dseq([85, 86, 88, 90], inf) ], // a demo sequence of midi pitches with two voices
	);

	strings = Blip.ar(
		midi.midicps*[1, 1, 8.04, 2], // convert midi to frequencies; array multiplier gives harmonics (SC multiplies arrays element-wise, so first voice gets 1 and 8.04, second 1 and 2)
		LFCub.ar(1, 0, 15, 15) // modulate number of harmonics
	).sum; // combine signals so various voices and harmonics blend

	organ = VarSaw.ar(
		midi.midicps*[1, 1, 8.04],
		LFCub.ar(1, 0, 8, 8) // causes a nice "crash" sound at the beginning
	).sum;

	mix = 0.75; // 1 = all strings, 0 = all organ
	signal = (mix*strings) + ((1-mix)*organ);
	signal = FreeVerb.ar(signal, 1, 1);

	// spread and remove high frequencies
	0.5*Splay.ar(
		LPF.ar(
			Limiter.ar(signal),
			2000
		)
	);
});
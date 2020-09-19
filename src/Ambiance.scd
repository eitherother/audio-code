
///////////////////////////////////////////////////////////////////////////////
// Ambiance. This is code prone to strong peaks and troughs and its tone color can
// also be pretty varied so I usually have to run it several times to get something I like.
(play
{
	var pitch, signal;

	// A sequence of notes demanded every 1/8 second
	pitch = Demand.kr(
		Impulse.kr(0.125),
		0,
		Dseq([ [ 216, 270 ], [ 192, 240 ], [ 162, 216 ], [ 144, 324 ], [ 54, 213, 432, 270, 864 ] ], inf));

	// Pass variable saw through comb with modulated delay
	signal = CombC.ar(
		VarSaw.ar(pitch, 0, {1.0.rand}.dup(2)),
		0.2,
		LFNoise1.kr(0.1, 0.01, 0.01)+0.1,
		6);

	signal = Splay.ar(signal);

	// Pass through a few dozen filters with shifting frequencies
	24.do{ signal=BBandStop.ar(
		signal,
		LFNoise1.kr(0.05.rand).exprange(1e2,1.3e4),
		exprand(0.25,2));
	};

	LPF.ar(HPF.ar(Limiter.ar(signal, 0.75), 20), 18000);
});


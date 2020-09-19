///////////////////////////////////////////////
// A quiet composition consisting of three sounds

// Synths - run this first
(SynthDef("QuasiHarmonica", {
	arg atk = 4, sus = 90, rel = 8, pan = 0, resonzFreq = 250, sin1Freq = 0.13, sin2Freq = 50;

	var ampEnv = Env([0.001, 1, 0.9, 0.0001], [atk, sus, rel], 'exp');
	var ampEnvGen = EnvGen.kr(ampEnv, doneAction:2);

	var sin1 = SinOsc.ar(sin1Freq, 0, 0.9, 1);
	var sin2 = SinOsc.ar(sin2Freq, 0, 0.9, 1);

	var quasiHarmonica = sin1 * sin2 * Resonz.ar(PinkNoise.ar(0.6), resonzFreq, 0.001);

	Out.ar(0, 2 * ampEnvGen * Pan2.ar(quasiHarmonica, pan, 1););
}).add;

SynthDef("Bouncing", {arg out = 0;
	var ampEnv = EnvGen.ar(Env([1, 4, 2, 0], [3, 8, 5]), doneAction:2);
	x = ampEnv*SinOsc.ar(Line.kr(1, 34, 10), 0, 0.9, 1)*Resonz.ar(PinkNoise.ar([1, 1]), 175, 0.001);
	Out.ar(out, Pan2.ar(x));
}).add;)



(r = Routine({
	// Gentle chords
	Synth("QuasiHarmonica", ["pan", -0.5]);
	4.wait;
	Synth("QuasiHarmonica", ["atk", 1, "sus", 90, "rel", 7, "sin1Freq", 0.2, "sin2Freq", 48, "resonzFreq", 200, "pan", 0.5]);
	8.wait;
	Synth("QuasiHarmonica", ["atk", 1, "sus", 81, "rel", 8, "sin1Freq", 1, "sin2Freq", 1, "resonzFreq", 225, "pan", 0]);

	// Bouncing
	6.wait;
	Synth("Bouncing");

	// Upward glissando
	4.wait;
	({
		var time = 80;
		var ampEnv = EnvGen.ar(Env([0.001, 1, 1, 0.001], [time/10, 4*time/5, time/10], 'exp'), doneAction:2);
		ampEnv*SinOsc.ar(Line.kr(240, 500, time), 0, Line.kr(0, 0.9, time), 1)*Resonz.ar(PinkNoise.ar([0.5, 0.5]), Line.kr(870, 1000, time), 0.001)
	}.play);

	22.wait;
	Synth("Bouncing");
	22.wait;
	Synth("Bouncing");
	22.wait;
	Synth("Bouncing");
}).play)

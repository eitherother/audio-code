//////////////////////////////////////////////////////////////////////////////////////
// Combine several noisy sources to generate something that sounds a little like radio static

(
SynthDef("crackle", {
	var crackleNoise = Crackle.ar(1.35, 0.1);
	crackleNoise = 0.5*LPF.ar(crackleNoise, LFNoise2.ar(0.25).range(1500, 2500));
	Out.ar(0,  Pan2.ar(crackleNoise, 0));
}).add;

SynthDef("whiteNoise", {
	var whiteNoise = WhiteNoise.ar(LFNoise1.ar(0.3).range(0.0003, 0.0006));
	Out.ar(0,  Pan2.ar(whiteNoise, 0));
}).add;

SynthDef("whiteNoiseHigh", {
	var noise = WhiteNoise.ar(LFNoise1.ar(0.3).range(0.0005, 0.0008));
	noise = HPF.ar(noise, LFNoise1.ar(0.5).range(4000, 12000));
	Out.ar(0,  Pan2.ar(noise, 0));
}).add;

SynthDef("humLo", {arg frequencyLo=100, frequencyHi=100;
	var humLo = SinOsc.ar(
		LFNoise1.kr(0.4).range(frequencyLo, frequencyHi),
		0,
		LFNoise1.ar(0.4).range(0.0003, 0.015));
	Out.ar(0,  Pan2.ar(humLo, 0));
}).add;

SynthDef("humHi", {arg frequency = 5423;
	var humHi = SinOsc.ar(frequency, 0, LFNoise1.ar(1).range(0.00002, 0.0002));
	Out.ar(0,  Pan2.ar(humHi, 0));
}).add;

SynthDef("ringing", {
	var humHi = SinOsc.ar(4162, 0, LFNoise1.ar(0.83).range(0.000001, 0.0002));
	humHi = humHi + SinOsc.ar(2498, 0, LFNoise1.ar(0.51).range(0.000001, 0.0002));
	humHi = humHi + SinOsc.ar(2508, 0, LFNoise1.ar(0.33).range(0.000001, 0.0002));
	Out.ar(0,  Pan2.ar(humHi, 0));
}).add;

SynthDef("humBuzz", {arg freq = 122, dustRangeLo = 2000, dustRangeHi = 4800;
	var hum, dustNoise, staticNoise;

	// sinusoidal hum with 10 harmonics
	hum = Array.fill(
		10,
		{|i| SinOsc.ar( (i+1) * freq, 0, 0.1)}
	).sum;

	// Modulate hum with noisy sources
	dustNoise = 0.35*Dust.ar(LFNoise1.ar(0.1).range(dustRangeLo, dustRangeHi)); // higher numbers in range reveal hum more clearly
	staticNoise = hum * dustNoise * LFNoise1.ar(1).range(0.5, 2);
	staticNoise = LPF.ar(staticNoise, LFNoise1.ar(0.75).range(200, 750));

	Out.ar(0,  Pan2.ar(staticNoise, 0));
}).add;

// Similar code to humBuzz, but a very different sound
SynthDef("resonantSpace", {
	var hum, dustNoise, staticNoise;
	hum = SinOsc.ar(1);
	dustNoise = 0.35*Dust.ar(LFNoise1.ar(0.1).range(800, 4000));
	staticNoise = hum * dustNoise * LFNoise1.ar(1).range(0.5, 2);
	staticNoise = LPF.ar(staticNoise, LFNoise1.ar(0.75).range(200, 750));
	staticNoise = FreeVerb.ar(staticNoise, 0.85, 0.85);

	Out.ar(0,  Pan2.ar(staticNoise, 0));
}).add;
)


(
a = Synth(\crackle);
b = Synth(\whiteNoise);
c = Synth(\whiteNoiseHigh);
d = Synth(\humLo);
e = Synth(\ringing);
f = Synth(\humHi);
g = Synth(\humBuzz);
)

// A bonus variation on the humBuzz instrument
r = Synth(\resonantSpace);



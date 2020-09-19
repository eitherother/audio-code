// A repeating routine of haunting glissandos over a bank of resonators

(
SynthDef("CombedKlank",
	{|out = 0, freqs = #[0, 0, 0, 0], rings = #[0, 0, 0, 0], combStart=0.00043, combEnd=0.00059, atk = 8, sus = 20, rel = 8, pan = 0|
		// Envelope
		var ampEnv = Env([0.001, 1.0, 1.0, 0.001], [atk, sus, rel], 'exp');
		var ampEnvGen = EnvGen.kr(ampEnv, doneAction:2);

		// Klank - bank of resonators stimulated by PinkNoise
		var klank = Klank.ar(`[freqs, nil, rings], PinkNoise.ar(0.005));

		// Pass Klank through comb filter to get glissando
		var combedKlank = CombL.ar(klank*0.5, 0.01, XLine.kr(combStart, combEnd, atk + sus + rel), 0.2);

		Out.ar(out, Pan2.ar(ampEnvGen*combedKlank, pan));
}).add;

r = Routine{
	0.5.wait;
    inf.do {
		// envelope
		var atk = 6.rand + 6;
		var sus = 10.rand + 15;
		var rel = 6.rand + 6;
		var period = (atk + sus + rel) * 0.35;

		// comb filter delays (determines glissando pitch)
		var combStart = 0.0001.rand + 0.00035;
		var combEnd = 0.0001.rand + 0.0005;

		var dups = 3.rand + 3;

		Synth("CombedKlank", [
            \atk, atk,
            \sus, sus,
            \rel, rel,
			\combStart, combStart,
			\combEnd, combEnd,
            \pan, 1.0.sum3rand,
			\freqs, {2000.0.linrand+80}.dup(dups),
			\rings, {0.1.rrand(3)}.dup(dups)
        ]);
        period.wait;
    }
};
r.play;
)

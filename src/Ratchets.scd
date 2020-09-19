
///////////////////////////////////////////////////////////////////////////////////////////////
// Ratchet sounds. General form is a series of impulses (LFPulse) passed through a filter (RHPF) to get
// some resonance. The SinOsc gives the sense of push and pull, speeding up and slowing down.

({ Pan2.ar(
	RHPF.ar(
		LFPulse.ar(
			SinOsc.kr(0.2, 0, 2, 4),
			0.1),
		3000,
		0.006).clip2(0.4),
	0,
	0.1)
}.play)

({ Pan2.ar(RHPF.ar(LFPulse.ar(SinOsc.kr(0.2, 0, 2, 4), 0.1), 3000, 0.005).clip2(0.3), 0, 0.5) }.play)
({ Pan2.ar(RHPF.ar(LFSaw.ar(SinOsc.kr(0.25, 0, 3, 5), 0), 3000, 0.005).clip2(0.1), 0, 0.5) }.play)
({ Resonz.ar(LFSaw.ar(10), XLine.kr(3000,3200, 5), 0.01, 3) + Resonz.ar(RHPF.ar(LFSaw.ar(10), 2000, 0.03), XLine.kr(2500,3500, 5), 0.01, 3)}.play)


// A variation on the ratchet - LFSaw instead of LFPulse, and multiply with Klank, to give some frequency color. This one is my favorite:
({
	var rhpf = RHPF.ar(LFSaw.ar(SinOsc.kr(0.25, 0, 3, 5), 0), 15000, 0.005).clip2(0.1) ;
	var klank =  Klank.ar(`[ (1,3..13)*200, 1/(1,3..13), nil ], PinkNoise.ar(0.01));
	Pan2.ar(rhpf*klank);
}.play)

{ Pan2.ar(RHPF.ar(LFPulse.ar(SinOsc.kr(0.2, 0, 3, 4), 0.1), 3000, 0.005).clip2(0.1)*Klank.ar(`[[440, 980, 1220, 1560], [1.0, 0.3, 0.15, 0.1], [2, 2, 2, 2]], WhiteNoise.ar(0.005))) }.play;
{ Pan2.ar(RHPF.ar(LFPulse.ar(SinOsc.kr(0.2, 0, 3, 4), 0.1), XLine.kr(20000, 15000, 15), 0.005).clip2(0.1)*Klank.ar(`[ (1,3..13)*200, 1/(1,3..13), nil ], PinkNoise.ar(0.07)))}.play;
{ Pan2.ar(RHPF.ar(LFPulse.ar(SinOsc.kr(0.2, 0, 3, 4), 0.1), XLine.kr(12500, 11000, 10), 0.005).clip2(0.1)*Klank.ar(`[ (1,3..13)*200, 1/(1,3..13), nil ], PinkNoise.ar(0.01))) }.play;
{ Pan2.ar(RHPF.ar(LFPulse.ar(SinOsc.kr(0.2, 0, 3, 4), 0.1), XLine.kr(8000, 7500, 5), 0.005).clip2(0.1)*Klank.ar(`[ (1,3..13)*200, 1/(1,3..13), nil ], PinkNoise.ar(0.07))) }.play;
{ Pan2.ar((RHPF.ar(LFSaw.ar(20), 2100, 0.05).clip2(0.1))*Klank.ar(`[[240], nil, [2]], BrownNoise.ar(0.005))) }.play;

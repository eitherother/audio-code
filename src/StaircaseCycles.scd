

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// An expressive mix that makes me think of climbing those Escher staircases, always ending up where they start

(play{
	var pitch, offset, onOff, frequencies;
	var stutter1, stutter2;
	var saw, pulse, mix, output;

	pitch = [57, 50, 64, 71];
	offset = [-2, -2, 1, 5];

	onOff = ceil(LFSaw.ar((1..4)/28)); // 4 channels alternating between 0 and 1 at different rates
	frequencies = midicps(pitch + (offset*onOff)); // Use onOff to alternate between pitches

	// variably mix two different tone colors
	saw = VarSaw.ar(frequencies, 0, LFTri.kr(1).range(0, 1), 0.1);
	pulse = Pulse.ar(frequencies, LFTri.kr(1).range(0, 1), 0.1);
	mix = SinOsc.kr(0.3, 0, 0.5, 0.5);
	output = (saw*(1-mix)) + (pulse*mix);

	// Add stuttering effect
	stutter1 = LFSaw.ar([1, 0.5, 6, 0.81]/4, 0, 0.5, 0.5);
	stutter2 = LFSaw.ar(0.5, 0.25, 2, 2);
	output = output % stutter1 % stutter2;

	// Splay channels and remove high and low frequencies
	output = HPF.ar(Splay.ar(output), 20);
	output = LPF.ar(output, 8000);
	0.15*GVerb.ar(output, 50, 2, 0.9);
})

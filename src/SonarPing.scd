//////////////////////////
// A simple sonar-like ping
({
    var env = Env([0, 1, 0, 0], [0.01, 0.5, 5]);
    var sin = SinOsc.ar(900) * EnvGen.kr(env, doneAction: 2);
	GVerb.ar(sin, 275, 1, 0.1, 0.4, 15, 0.79, 0.28, 0.35, 275, 0.3);
}.play)


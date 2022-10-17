import("stdfaust.lib");

// filter permamitors 

filter(Q,F,G)	= fi.TF2(  (1 +  K/Q + K*K) 	/ D,
						 2 * (K*K - 1) 		/ D,
						(1 - K/Q + K*K) 	/ D,
						 2 * (K*K - 1) 		/ D,
						(1 - V*K/Q + K*K) 	/ D
					 )
		with {
				V = ba.db2linear(G);
				K = tan(ma.PI*F/ma.SR);
				D = 1 + V*K/Q + K*K;
		};

// freq bands

treble(F) = filter(	nentry("width[style:knob]",0.6,0.1,2,0.1),
							nentry("freq[unit:Hz][style:knob]", F, 1000, 20000, 100),
							0 - nentry("gain[unit:dB] [style:knob]", 0, -50, 50, 0.1)
						);

himid(F) = filter(	nentry("width[style:knob]",0.6,0.1,2,0.1),
							nentry("freq[unit:Hz][style:knob]", F, 400, 8000, 100),
							0 - nentry("gain[unit:dB] [style:knob]", 0, -50, 50, 0.1)
						);
lomid(F) = filter(	nentry("width[style:knob]",0.6,0.1,2,0.1),
							nentry("freq[unit:Hz][style:knob]", F, 100, 2000, 100),
							0 - nentry("gain[unit:dB] [style:knob]", 0, -50, 50, 0.1)
						);

bass(F)	= filter(	nentry("width[style:knob]",0.6,0.1,2,0.1),
							nentry("freq[unit:Hz][style:knob]", F, 20, 400, 5),
							0 - nentry("gain[unit:dB] [style:knob]", 0, -50, 50, 0.1)
						);

mute = *(0-checkbox("IN"));


process =  mute : hgroup("hi mid", himid(700)) : hgroup("treble", treble(2000)) : hgroup("lo mid", lomid(200)) : hgroup("bass", bass(35));

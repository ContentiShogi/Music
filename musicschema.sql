DROP TABLE [triad_set_class_expanded]
GO
DROP TABLE [thaat_scale_map]
GO
DROP TABLE [thaat]
GO
DROP TABLE [taal]
GO
DROP TABLE [subthaat]
GO
DROP TABLE [scales]
GO
DROP TABLE [scale_triad_chart]
GO
DROP TABLE [scale_romans_wrong_deg_triads]
GO
DROP TABLE [scale_romans]
GO
DROP TABLE [scale_interval_chart]
GO
DROP TABLE [raagable_scales]
GO
DROP TABLE [raag2]
GO
DROP TABLE [raag_jati_scales]
GO
DROP TABLE [raag_jati]
GO
DROP TABLE [raag]
GO
DROP TABLE [pitch_scale_map]
GO
DROP TABLE [pitch_class_rotation_map]
GO
DROP TABLE [pitch]
GO
DROP TABLE [notes]
GO
DROP TABLE [note_transpositions_chromatic]
GO
DROP TABLE [normal_scales]
GO
DROP TABLE [melakarta_raga]
GO
DROP TABLE [melakarta_janya_raga]
GO
DROP TABLE [key_signatures]
GO
DROP TABLE [intervals]
GO
DROP TABLE [gharana]
GO
DROP TABLE [dynamics]
GO
DROP TABLE [duration]
GO
DROP TABLE [chords_extra]
GO
DROP TABLE [chords]
GO
DROP TABLE [chord_set_classes]
GO
DROP TABLE [bol]
GO
DROP TABLE [bandish]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bandish](
	[id] [varchar](4) NOT NULL,
	[Title] [nvarchar](62) NOT NULL,
	[Raag] [nvarchar](60) NOT NULL,
	[Taal] [nvarchar](15) NOT NULL,
	[Tempo] [nvarchar](12) NOT NULL,
	[Performer] [nvarchar](48) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bol](
	[hands] [int] NOT NULL,
	[bol] [varchar](13) NOT NULL,
	[tablaplace] [varchar](11) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [chord_set_classes](
	[_id] [bigint] NULL,
	[forte_num] [nvarchar](6) NOT NULL,
	[prime_form] [nvarchar](4000) NULL,
	[interval_vector] [nvarchar](13) NOT NULL,
	[carter_num] [int] NULL,
	[spacings] [nvarchar](39) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [chords](
	[chord] [nvarchar](59) NOT NULL,
	[forte_num] [nvarchar](5) NOT NULL,
	[pitch_class] [nvarchar](4000) NULL,
	[chord_type] [nvarchar](13) NOT NULL,
	[example] [nvarchar](16) NULL,
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[compact_pitch_class] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [chords_extra](
	[chord] [nvarchar](59) NOT NULL,
	[forte_num] [nvarchar](5) NOT NULL,
	[pitch_class] [nvarchar](4000) NULL,
	[chord_type] [nvarchar](13) NOT NULL,
	[example] [nvarchar](16) NULL,
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[roman_numerals] [nvarchar](8) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [duration](
	[_id] [int] NOT NULL,
	[duration_ratio] [numeric](7, 6) NULL,
	[note_name] [varchar](22) NOT NULL,
	[note_symbol] [nvarchar](2) NOT NULL,
	[_1dot] [float] NULL,
	[_2dot] [float] NULL,
	[_3dot] [float] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dynamics](
	[_id] [int] NOT NULL,
	[dynamics] [varchar](5) NOT NULL,
	[example] [varchar](26) NOT NULL,
	[velocity_musescore] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [gharana](
	[Gharana] [varchar](20) NOT NULL,
	[Gharana_Type] [nvarchar](8) NOT NULL,
	[Founder] [nvarchar](40) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [intervals](
	[distance] [int] NOT NULL,
	[generic_dist] [numeric](2, 1) NOT NULL,
	[interval] [varchar](35) NOT NULL,
	[pat_bit] [varchar](13) NOT NULL,
	[bitnum] [int] NOT NULL,
	[diatonic_degree_name] [varchar](25) NOT NULL,
	[in_radians] [float] NULL,
	[abbr] [nvarchar](8) NULL,
	[abbr2] [nvarchar](8) NULL,
	[interval_class] [tinyint] NULL,
	[chord_w_this_root_in_Locrian] [nvarchar](8) NULL,
	[chord_w_this_root_in_Major] [nvarchar](8) NULL,
	[chord_w_this_root_in_Dorian] [nvarchar](8) NULL,
	[chord_w_this_root_in_Phrygian] [nvarchar](8) NULL,
	[chord_w_this_root_in_Lydian] [nvarchar](8) NULL,
	[chord_w_this_root_in_Mixolydian] [nvarchar](8) NULL,
	[chord_w_this_root_in_Minor] [nvarchar](8) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [key_signatures](
	[rn] [bigint] NULL,
	[key_signature] [varchar](20) NOT NULL,
	[Major_key] [varchar](8) NOT NULL,
	[Minor_key] [varchar](8) NOT NULL,
	[keysig_pat] [nvarchar](256) NULL,
	[sharp_count] [int] NOT NULL,
	[flat_count] [int] NOT NULL,
	[in_radians] [float] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [melakarta_janya_raga](
	[raag] [varchar](20) NOT NULL,
	[melakarta_id] [int] NULL,
	[aaroha] [varchar](23) NOT NULL,
	[avaroha] [varchar](26) NOT NULL,
	[similar_hindustani] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [melakarta_raga](
	[_id] [int] NOT NULL,
	[raga] [varchar](21) NOT NULL,
	[aaroha] [varchar](20) NOT NULL,
	[avaroha] [varchar](20) NOT NULL,
	[similar_hindustani] [varchar](256) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [normal_scales](
	[scale_id] [int] NOT NULL,
	[scale] [nvarchar](256) NULL,
	[rotate_by] [nvarchar](4000) NULL,
	[compact_form] [nvarchar](256) NULL,
	[compact_scale_id] [int] NOT NULL,
	[packdir] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [note_transpositions_chromatic](
	[note_id] [int] NOT NULL,
	[interval] [int] NOT NULL,
	[transposition_chromatic] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [notes](
	[_id] [int] NOT NULL,
	[swar] [varchar](10) NULL,
	[note] [varchar](2) NOT NULL,
	[ratio] [numeric](8, 6) NULL,
	[pat] [varchar](1) NOT NULL,
	[pat_bit] [varchar](12) NULL,
	[bitpat_up] [int] NULL,
	[bitpat_down] [int] NULL,
	[abbr] [char](1) NULL,
	[__id] [int] NULL,
	[mult0] [char](1) NULL,
	[mult1] [char](1) NULL,
	[mult2] [char](1) NULL,
	[mult3] [char](1) NULL,
	[mult4] [char](1) NULL,
	[mult5] [char](1) NULL,
	[mult6] [char](1) NULL,
	[mult7] [char](1) NULL,
	[mult8] [char](1) NULL,
	[mult9] [char](1) NULL,
	[mult10] [char](1) NULL,
	[mult11] [char](1) NULL,
	[carnatic_swar] [varchar](10) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pitch](
	[_id] [int] NOT NULL,
	[pitches_sh_maj] [varchar](2) NOT NULL,
	[pitches_fl_maj] [varchar](2) NOT NULL,
	[maj_scale_sh] [nvarchar](256) NULL,
	[min_scale_sh] [nvarchar](256) NULL,
	[pitches_sh_min] [varchar](2) NULL,
	[pitches_fl_min] [varchar](2) NULL,
	[maj_scale_fl] [nvarchar](256) NULL,
	[min_scale_fl] [nvarchar](256) NULL,
	[maj_scale_notes] [nvarchar](256) NULL,
	[min_scale_notes] [nvarchar](256) NULL,
	[keysig_min] [nvarchar](8) NULL,
	[keysig_maj] [nvarchar](8) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pitch_class_rotation_map](
	[_id] [bigint] NULL,
	[forte_num] [nvarchar](6) NOT NULL,
	[prime_form] [nvarchar](4000) NULL,
	[pitch_rotn] [varchar](30) NULL,
	[rotate_by] [varchar](40) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pitch_scale_map](
	[pitch_id] [int] NULL,
	[scale_id] [int] NULL,
	[pitch_sh] [nvarchar](8) NULL,
	[pitch_fl] [nvarchar](8) NULL,
	[scale_steps] [nvarchar](64) NULL,
	[scale_pat_in_key] [nvarchar](256) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raag](
	[Raag] [varchar](60) NOT NULL,
	[Old_Thaat] [varchar](14) NULL,
	[New_Thaat] [varchar](14) NULL,
	[Prahar] [varchar](1) NULL,
	[Raag_Time] [varchar](7) NULL,
	[jati] [varchar](256) NULL,
	[vadi] [int] NULL,
	[samvadi] [int] NULL,
	[mukhya_ang] [varchar](256) NULL,
	[aaroh] [varchar](512) NULL,
	[avaroh] [varchar](512) NULL,
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[aaroh_scale_id] [int] NULL,
	[avroh_scale_id] [int] NULL,
	[vishranti_aaroh] [varchar](256) NULL,
	[vishranti_avroh] [varchar](256) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raag_jati](
	[_id] [bigint] NULL,
	[vakra] [int] NOT NULL,
	[aarohnotes] [int] NOT NULL,
	[avrohnotes] [int] NOT NULL,
	[jati] [varchar](19) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raag_jati_scales](
	[jati] [varchar](19) NOT NULL,
	[aaroh_scale_id] [int] NOT NULL,
	[avroh_scale_id] [int] NOT NULL,
	[complete_scale_id] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raag2](
	[raag] [varchar](17) NOT NULL,
	[thaat] [varchar](8) NOT NULL,
	[aaroh] [varchar](256) NULL,
	[avroh] [varchar](256) NULL,
	[pakad] [varchar](256) NULL,
	[vadi] [varchar](2) NOT NULL,
	[samvadi] [varchar](1) NOT NULL,
	[prahar] [varchar](24) NOT NULL,
	[remarks] [varchar](100) NULL,
	[aarohnotes] [varchar](256) NULL,
	[avrohnotes] [varchar](256) NULL,
	[aarohscale] [varchar](256) NULL,
	[avrohscale] [varchar](256) NULL,
	[pakadscale] [varchar](256) NULL,
	[pakadnotes] [varchar](256) NULL,
	[complete_scale] [varchar](256) NULL,
	[aarohpattern] [varchar](256) NULL,
	[avrohpattern] [varchar](256) NULL,
	[pakadpattern] [varchar](256) NULL,
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[compactcompletescale] [varchar](500) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [raagable_scales](
	[_id] [bigint] NULL,
	[scale_id] [int] NOT NULL,
	[tones] [tinyint] NULL,
	[vikrit_count] [int] NULL,
	[thaat_count] [int] NULL,
	[thaats] [varchar](8000) NULL,
	[steps] [nvarchar](24) NULL,
	[pat_up] [nvarchar](256) NULL,
	[pat_bit] [char](12) NULL,
	[bitnum_up] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [scale_interval_chart](
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[scales] [varchar](30) NULL,
	[degree] [int] NULL,
	[intervals] [varchar](256) NULL,
	[interval_classes] [varchar](256) NULL,
	[variety] [float] NULL,
	[triad_harmony] [nvarchar](512) NULL,
	[wrong_deg_triad] [varchar](8000) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [scale_romans](
	[scale_id] [int] NOT NULL,
	[Step_Family] [varchar](35) NULL,
	[Shape] [nchar](1) NULL,
	[Degree] [nchar](4) NULL,
	[scale_note] [int] NULL,
	[ref_note] [int] NULL,
	[scale_note_degree] [bigint] NULL,
	[roman] [nvarchar](4000) NULL,
	[wrong_deg_roman] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [scale_romans_wrong_deg_triads](
	[scale_id] [int] NOT NULL,
	[triadcompact] [varchar](52) NOT NULL,
	[right_deg_roman] [nvarchar](4000) NULL,
	[wrong_deg_roman] [nvarchar](4000) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [scale_triad_chart](
	[_id] [int] NOT NULL,
	[triad] [nvarchar](4000) NULL,
	[triad_type] [varchar](21) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [scales](
	[Tones] [tinyint] NULL,
	[Step_Family] [varchar](35) NULL,
	[Iteration] [tinyint] NULL,
	[Shape] [nchar](1) NULL,
	[Degree] [nchar](4) NULL,
	[Steps] [nvarchar](24) NULL,
	[Names] [nvarchar](512) NULL,
	[sa] [bit] NULL,
	[reko] [bit] NULL,
	[re] [bit] NULL,
	[gako] [bit] NULL,
	[ga] [bit] NULL,
	[ma] [bit] NULL,
	[mati] [bit] NULL,
	[pa] [bit] NULL,
	[dhako] [bit] NULL,
	[dha] [bit] NULL,
	[niko] [bit] NULL,
	[ni] [bit] NULL,
	[saa] [bit] NULL,
	[pat_up] [nvarchar](256) NULL,
	[pat_down] [nvarchar](256) NULL,
	[pat_bit] [char](12) NULL,
	[bitnum_up] [int] NULL,
	[bitnum_down] [int] NULL,
	[_id] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [subthaat](
	[scale_id] [int] NOT NULL,
	[bitnum_up] [int] NULL,
	[bin] [varchar](max) NOT NULL,
	[bitnum_combo] [varchar](8000) NULL,
	[combo_count] [int] NULL,
	[vikrit_count] [int] NULL,
	[tones] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [taal](
	[taal] [varchar](32) NOT NULL,
	[beats] [nvarchar](4) NOT NULL,
	[taali] [nvarchar](53) NOT NULL,
	[khaali] [nvarchar](15) NOT NULL,
	[_id] [int] IDENTITY(1,1) NOT NULL,
	[beatpat] [nvarchar](256) NULL,
	[beatpat_rev] [nvarchar](256) NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [thaat](
	[_id] [bigint] NULL,
	[thaat] [varchar](256) NULL,
	[pat_bit] [varchar](12) NOT NULL,
	[bitnum_up] [int] NULL,
	[bitnum_down] [int] NULL,
	[theorist] [varchar](256) NULL,
	[vikrit_count] [int] NULL,
	[scale_id] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [thaat_scale_map](
	[thaat_id] [bigint] NULL,
	[scale_id] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [triad_set_class_expanded](
	[_id] [bigint] NULL,
	[forte_num] [nvarchar](6) NOT NULL,
	[prime_form] [nvarchar](4000) NULL,
	[interval_vector] [nvarchar](13) NOT NULL,
	[carter_num] [int] NULL,
	[spacings] [nvarchar](39) NOT NULL,
	[pc1] [int] NULL,
	[pc2] [int] NULL,
	[pc3] [int] NULL,
	[t_a] [bigint] NULL,
	[t_b] [bigint] NULL,
	[triad] [varchar](256) NULL,
	[intervals] [varchar](256) NULL
) ON [PRIMARY]
GO

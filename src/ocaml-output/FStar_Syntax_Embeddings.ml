
open Prims
open FStar_Pervasives

type 'a embedder =
FStar_Range.range  ->  'a  ->  FStar_Syntax_Syntax.term


type 'a unembedder =
FStar_Syntax_Syntax.term  ->  'a FStar_Pervasives_Native.option


let embed_unit : FStar_Range.range  ->  Prims.unit  ->  FStar_Syntax_Syntax.term = (fun rng u -> (

let uu___221_28 = FStar_Syntax_Util.exp_unit
in {FStar_Syntax_Syntax.n = uu___221_28.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.pos = rng; FStar_Syntax_Syntax.vars = uu___221_28.FStar_Syntax_Syntax.vars}))


let __unembed_unit : Prims.bool  ->  FStar_Syntax_Syntax.term  ->  Prims.unit FStar_Pervasives_Native.option = (fun w t0 -> (

let t = (FStar_Syntax_Util.unascribe t0)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_unit) -> begin
FStar_Pervasives_Native.Some (())
end
| uu____46 -> begin
((match (w) with
| true -> begin
(

let uu____48 = (

let uu____49 = (FStar_Syntax_Print.term_to_string t)
in (FStar_Util.format1 "Not an embedded unit: %s" uu____49))
in (FStar_Errors.warn t0.FStar_Syntax_Syntax.pos uu____48))
end
| uu____50 -> begin
()
end);
FStar_Pervasives_Native.None;
)
end)))


let unembed_unit : FStar_Syntax_Syntax.term  ->  Prims.unit FStar_Pervasives_Native.option = (fun t -> (__unembed_unit true t))


let unembed_unit_safe : FStar_Syntax_Syntax.term  ->  Prims.unit FStar_Pervasives_Native.option = (fun t -> (__unembed_unit false t))


let embed_bool : FStar_Range.range  ->  Prims.bool  ->  FStar_Syntax_Syntax.term = (fun rng b -> (

let t = (match (b) with
| true -> begin
FStar_Syntax_Util.exp_true_bool
end
| uu____83 -> begin
FStar_Syntax_Util.exp_false_bool
end)
in (

let uu___222_84 = t
in {FStar_Syntax_Syntax.n = uu___222_84.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.pos = rng; FStar_Syntax_Syntax.vars = uu___222_84.FStar_Syntax_Syntax.vars})))


let __unembed_bool : Prims.bool  ->  FStar_Syntax_Syntax.term  ->  Prims.bool FStar_Pervasives_Native.option = (fun w t0 -> (

let t = (FStar_Syntax_Util.unmeta_safe t0)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_bool (b)) -> begin
FStar_Pervasives_Native.Some (b)
end
| uu____103 -> begin
((match (w) with
| true -> begin
(

let uu____105 = (

let uu____106 = (FStar_Syntax_Print.term_to_string t0)
in (FStar_Util.format1 "Not an embedded bool: %s" uu____106))
in (FStar_Errors.warn t0.FStar_Syntax_Syntax.pos uu____105))
end
| uu____107 -> begin
()
end);
FStar_Pervasives_Native.None;
)
end)))


let unembed_bool : FStar_Syntax_Syntax.term  ->  Prims.bool FStar_Pervasives_Native.option = (fun t -> (__unembed_bool true t))


let unembed_bool_safe : FStar_Syntax_Syntax.term  ->  Prims.bool FStar_Pervasives_Native.option = (fun t -> (__unembed_bool false t))


let embed_char : FStar_Range.range  ->  FStar_Char.char  ->  FStar_Syntax_Syntax.term = (fun rng c -> (

let t = (FStar_Syntax_Util.exp_char c)
in (

let uu___223_136 = t
in {FStar_Syntax_Syntax.n = uu___223_136.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.pos = rng; FStar_Syntax_Syntax.vars = uu___223_136.FStar_Syntax_Syntax.vars})))


let __unembed_char : Prims.bool  ->  FStar_Syntax_Syntax.term  ->  FStar_Char.char FStar_Pervasives_Native.option = (fun w t0 -> (

let t = (FStar_Syntax_Util.unmeta_safe t0)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_char (c)) -> begin
FStar_Pervasives_Native.Some (c)
end
| uu____153 -> begin
((match (w) with
| true -> begin
(

let uu____155 = (

let uu____156 = (FStar_Syntax_Print.term_to_string t0)
in (FStar_Util.format1 "Not an embedded char: %s" uu____156))
in (FStar_Errors.warn t0.FStar_Syntax_Syntax.pos uu____155))
end
| uu____157 -> begin
()
end);
FStar_Pervasives_Native.None;
)
end)))


let unembed_char : FStar_Syntax_Syntax.term  ->  FStar_Char.char FStar_Pervasives_Native.option = (fun t -> (__unembed_char true t))


let unembed_char_safe : FStar_Syntax_Syntax.term  ->  FStar_Char.char FStar_Pervasives_Native.option = (fun t -> (__unembed_char false t))


let embed_int : FStar_Range.range  ->  FStar_BigInt.t  ->  FStar_Syntax_Syntax.term = (fun rng i -> (

let t = (

let uu____186 = (FStar_BigInt.string_of_big_int i)
in (FStar_Syntax_Util.exp_int uu____186))
in (

let uu___224_187 = t
in {FStar_Syntax_Syntax.n = uu___224_187.FStar_Syntax_Syntax.n; FStar_Syntax_Syntax.pos = rng; FStar_Syntax_Syntax.vars = uu___224_187.FStar_Syntax_Syntax.vars})))


let __unembed_int : Prims.bool  ->  FStar_Syntax_Syntax.term  ->  FStar_BigInt.t FStar_Pervasives_Native.option = (fun w t0 -> (

let t = (FStar_Syntax_Util.unmeta_safe t0)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_int (s, uu____204)) -> begin
(

let uu____217 = (FStar_BigInt.big_int_of_string s)
in FStar_Pervasives_Native.Some (uu____217))
end
| uu____218 -> begin
((match (w) with
| true -> begin
(

let uu____220 = (

let uu____221 = (FStar_Syntax_Print.term_to_string t0)
in (FStar_Util.format1 "Not an embedded int: %s" uu____221))
in (FStar_Errors.warn t0.FStar_Syntax_Syntax.pos uu____220))
end
| uu____222 -> begin
()
end);
FStar_Pervasives_Native.None;
)
end)))


let unembed_int : FStar_Syntax_Syntax.term  ->  FStar_BigInt.t FStar_Pervasives_Native.option = (fun t -> (__unembed_int true t))


let unembed_int_safe : FStar_Syntax_Syntax.term  ->  FStar_BigInt.t FStar_Pervasives_Native.option = (fun t -> (__unembed_int false t))


let embed_string : FStar_Range.range  ->  Prims.string  ->  FStar_Syntax_Syntax.term = (fun rng s -> (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_string (((s), (rng))))) FStar_Pervasives_Native.None rng))


let __unembed_string : Prims.bool  ->  FStar_Syntax_Syntax.term  ->  Prims.string FStar_Pervasives_Native.option = (fun w t0 -> (

let t = (FStar_Syntax_Util.unmeta_safe t0)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_string (s, uu____266)) -> begin
FStar_Pervasives_Native.Some (s)
end
| uu____267 -> begin
((match (w) with
| true -> begin
(

let uu____269 = (

let uu____270 = (FStar_Syntax_Print.term_to_string t0)
in (FStar_Util.format1 "Not an embedded string: %s" uu____270))
in (FStar_Errors.warn t0.FStar_Syntax_Syntax.pos uu____269))
end
| uu____271 -> begin
()
end);
FStar_Pervasives_Native.None;
)
end)))


let unembed_string : FStar_Syntax_Syntax.term  ->  Prims.string FStar_Pervasives_Native.option = (fun t -> (__unembed_string true t))


let unembed_string_safe : FStar_Syntax_Syntax.term  ->  Prims.string FStar_Pervasives_Native.option = (fun t -> (__unembed_string false t))


let embed_pair : 'a 'b . 'a embedder  ->  FStar_Syntax_Syntax.typ  ->  'b embedder  ->  FStar_Syntax_Syntax.typ  ->  ('a * 'b) embedder = (fun embed_a t_a embed_b t_b rng x -> (

let uu____361 = (

let uu____362 = (

let uu____363 = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.lid_Mktuple2)
in (FStar_Syntax_Syntax.mk_Tm_uinst uu____363 ((FStar_Syntax_Syntax.U_zero)::(FStar_Syntax_Syntax.U_zero)::[])))
in (

let uu____364 = (

let uu____365 = (FStar_Syntax_Syntax.iarg t_a)
in (

let uu____366 = (

let uu____369 = (FStar_Syntax_Syntax.iarg t_b)
in (

let uu____370 = (

let uu____373 = (

let uu____374 = (embed_a rng (FStar_Pervasives_Native.fst x))
in (FStar_Syntax_Syntax.as_arg uu____374))
in (

let uu____378 = (

let uu____381 = (

let uu____382 = (embed_b rng (FStar_Pervasives_Native.snd x))
in (FStar_Syntax_Syntax.as_arg uu____382))
in (uu____381)::[])
in (uu____373)::uu____378))
in (uu____369)::uu____370))
in (uu____365)::uu____366))
in (FStar_Syntax_Syntax.mk_Tm_app uu____362 uu____364)))
in (uu____361 FStar_Pervasives_Native.None rng)))


let __unembed_pair : 'a 'b . Prims.bool  ->  'a unembedder  ->  'b unembedder  ->  FStar_Syntax_Syntax.term  ->  ('a * 'b) FStar_Pervasives_Native.option = (fun w unembed_a unembed_b t0 -> (

let t = (FStar_Syntax_Util.unmeta_safe t0)
in (

let uu____441 = (FStar_Syntax_Util.head_and_args t)
in (match (uu____441) with
| (hd1, args) -> begin
(

let uu____484 = (

let uu____497 = (

let uu____498 = (FStar_Syntax_Util.un_uinst hd1)
in uu____498.FStar_Syntax_Syntax.n)
in ((uu____497), (args)))
in (match (uu____484) with
| (FStar_Syntax_Syntax.Tm_fvar (fv), (uu____516)::(uu____517)::((a, uu____519))::((b, uu____521))::[]) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.lid_Mktuple2) -> begin
(

let uu____580 = (unembed_a a)
in (FStar_Util.bind_opt uu____580 (fun a1 -> (

let uu____592 = (unembed_b b)
in (FStar_Util.bind_opt uu____592 (fun b1 -> FStar_Pervasives_Native.Some (((a1), (b1)))))))))
end
| uu____607 -> begin
((match (w) with
| true -> begin
(

let uu____621 = (

let uu____622 = (FStar_Syntax_Print.term_to_string t0)
in (FStar_Util.format1 "Not an embedded pair: %s" uu____622))
in (FStar_Errors.warn t0.FStar_Syntax_Syntax.pos uu____621))
end
| uu____623 -> begin
()
end);
FStar_Pervasives_Native.None;
)
end))
end))))


let unembed_pair : 'a 'b . 'a unembedder  ->  'b unembedder  ->  ('a * 'b) unembedder = (fun ul ur t -> (__unembed_pair true ul ur t))


let unembed_pair_safe : 'a 'b . 'a unembedder  ->  'b unembedder  ->  ('a * 'b) unembedder = (fun ul ur t -> (__unembed_pair false ul ur t))


let embed_option : 'a . 'a embedder  ->  FStar_Syntax_Syntax.typ  ->  'a FStar_Pervasives_Native.option embedder = (fun embed_a typ rng o -> (match (o) with
| FStar_Pervasives_Native.None -> begin
(

let uu____784 = (

let uu____785 = (

let uu____786 = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.none_lid)
in (FStar_Syntax_Syntax.mk_Tm_uinst uu____786 ((FStar_Syntax_Syntax.U_zero)::[])))
in (

let uu____787 = (

let uu____788 = (FStar_Syntax_Syntax.iarg typ)
in (uu____788)::[])
in (FStar_Syntax_Syntax.mk_Tm_app uu____785 uu____787)))
in (uu____784 FStar_Pervasives_Native.None rng))
end
| FStar_Pervasives_Native.Some (a) -> begin
(

let uu____792 = (

let uu____793 = (

let uu____794 = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.some_lid)
in (FStar_Syntax_Syntax.mk_Tm_uinst uu____794 ((FStar_Syntax_Syntax.U_zero)::[])))
in (

let uu____795 = (

let uu____796 = (FStar_Syntax_Syntax.iarg typ)
in (

let uu____797 = (

let uu____800 = (

let uu____801 = (embed_a rng a)
in (FStar_Syntax_Syntax.as_arg uu____801))
in (uu____800)::[])
in (uu____796)::uu____797))
in (FStar_Syntax_Syntax.mk_Tm_app uu____793 uu____795)))
in (uu____792 FStar_Pervasives_Native.None rng))
end))


let __unembed_option : 'a . Prims.bool  ->  'a unembedder  ->  FStar_Syntax_Syntax.term  ->  'a FStar_Pervasives_Native.option FStar_Pervasives_Native.option = (fun w unembed_a t0 -> (

let t = (FStar_Syntax_Util.unmeta_safe t0)
in (

let uu____841 = (FStar_Syntax_Util.head_and_args t)
in (match (uu____841) with
| (hd1, args) -> begin
(

let uu____882 = (

let uu____895 = (

let uu____896 = (FStar_Syntax_Util.un_uinst hd1)
in uu____896.FStar_Syntax_Syntax.n)
in ((uu____895), (args)))
in (match (uu____882) with
| (FStar_Syntax_Syntax.Tm_fvar (fv), uu____912) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.none_lid) -> begin
FStar_Pervasives_Native.Some (FStar_Pervasives_Native.None)
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), (uu____932)::((a, uu____934))::[]) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.some_lid) -> begin
(

let uu____971 = (unembed_a a)
in (FStar_Util.bind_opt uu____971 (fun a1 -> FStar_Pervasives_Native.Some (FStar_Pervasives_Native.Some (a1)))))
end
| uu____982 -> begin
((match (w) with
| true -> begin
(

let uu____996 = (

let uu____997 = (FStar_Syntax_Print.term_to_string t0)
in (FStar_Util.format1 "Not an embedded option: %s" uu____997))
in (FStar_Errors.warn t0.FStar_Syntax_Syntax.pos uu____996))
end
| uu____998 -> begin
()
end);
FStar_Pervasives_Native.None;
)
end))
end))))


let unembed_option : 'a . 'a unembedder  ->  'a FStar_Pervasives_Native.option unembedder = (fun ua t -> (__unembed_option true ua t))


let unembed_option_safe : 'a . 'a unembedder  ->  'a FStar_Pervasives_Native.option unembedder = (fun ua t -> (__unembed_option false ua t))


let rec embed_list : 'a . 'a embedder  ->  FStar_Syntax_Syntax.typ  ->  'a Prims.list embedder = (fun embed_a typ rng l -> (match (l) with
| [] -> begin
(

let uu____1108 = (

let uu____1109 = (

let uu____1110 = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.nil_lid)
in (FStar_Syntax_Syntax.mk_Tm_uinst uu____1110 ((FStar_Syntax_Syntax.U_zero)::[])))
in (

let uu____1111 = (

let uu____1112 = (FStar_Syntax_Syntax.iarg typ)
in (uu____1112)::[])
in (FStar_Syntax_Syntax.mk_Tm_app uu____1109 uu____1111)))
in (uu____1108 FStar_Pervasives_Native.None rng))
end
| (hd1)::tl1 -> begin
(

let uu____1119 = (

let uu____1120 = (

let uu____1121 = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.cons_lid)
in (FStar_Syntax_Syntax.mk_Tm_uinst uu____1121 ((FStar_Syntax_Syntax.U_zero)::[])))
in (

let uu____1122 = (

let uu____1123 = (FStar_Syntax_Syntax.iarg typ)
in (

let uu____1124 = (

let uu____1127 = (

let uu____1128 = (embed_a rng hd1)
in (FStar_Syntax_Syntax.as_arg uu____1128))
in (

let uu____1132 = (

let uu____1135 = (

let uu____1136 = (

let uu____1137 = (embed_list embed_a typ)
in (uu____1137 rng tl1))
in (FStar_Syntax_Syntax.as_arg uu____1136))
in (uu____1135)::[])
in (uu____1127)::uu____1132))
in (uu____1123)::uu____1124))
in (FStar_Syntax_Syntax.mk_Tm_app uu____1120 uu____1122)))
in (uu____1119 FStar_Pervasives_Native.None rng))
end))


let rec __unembed_list : 'a . Prims.bool  ->  'a unembedder  ->  FStar_Syntax_Syntax.term  ->  'a Prims.list FStar_Pervasives_Native.option = (fun w unembed_a t0 -> (

let t = (FStar_Syntax_Util.unmeta_safe t0)
in (

let uu____1187 = (FStar_Syntax_Util.head_and_args t)
in (match (uu____1187) with
| (hd1, args) -> begin
(

let uu____1228 = (

let uu____1241 = (

let uu____1242 = (FStar_Syntax_Util.un_uinst hd1)
in uu____1242.FStar_Syntax_Syntax.n)
in ((uu____1241), (args)))
in (match (uu____1228) with
| (FStar_Syntax_Syntax.Tm_fvar (fv), uu____1258) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.nil_lid) -> begin
FStar_Pervasives_Native.Some ([])
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), (_t)::((hd2, uu____1280))::((tl1, uu____1282))::[]) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.cons_lid) -> begin
(

let uu____1329 = (unembed_a hd2)
in (FStar_Util.bind_opt uu____1329 (fun hd3 -> (

let uu____1339 = (__unembed_list w unembed_a tl1)
in (FStar_Util.bind_opt uu____1339 (fun tl2 -> FStar_Pervasives_Native.Some ((hd3)::tl2)))))))
end
| uu____1358 -> begin
((match (w) with
| true -> begin
(

let uu____1372 = (

let uu____1373 = (FStar_Syntax_Print.term_to_string t0)
in (FStar_Util.format1 "Not an embedded list: %s" uu____1373))
in (FStar_Errors.warn t0.FStar_Syntax_Syntax.pos uu____1372))
end
| uu____1374 -> begin
()
end);
FStar_Pervasives_Native.None;
)
end))
end))))


let unembed_list : 'a . 'a unembedder  ->  'a Prims.list unembedder = (fun ua t -> (__unembed_list true ua t))


let unembed_list_safe : 'a . 'a unembedder  ->  'a Prims.list unembedder = (fun ua t -> (__unembed_list false ua t))


let embed_string_list : FStar_Range.range  ->  Prims.string Prims.list  ->  FStar_Syntax_Syntax.term = (fun rng ss -> (

let uu____1458 = (embed_list embed_string FStar_Syntax_Syntax.t_string)
in (uu____1458 rng ss)))


let unembed_string_list : FStar_Syntax_Syntax.term  ->  Prims.string Prims.list FStar_Pervasives_Native.option = (fun t -> (

let uu____1476 = (unembed_list unembed_string)
in (uu____1476 t)))


let unembed_string_list_safe : FStar_Syntax_Syntax.term  ->  Prims.string Prims.list FStar_Pervasives_Native.option = (fun t -> (

let uu____1493 = (unembed_list_safe unembed_string_safe)
in (uu____1493 t)))

type norm_step =
| Simpl
| Weak
| HNF
| Primops
| Delta
| Zeta
| Iota
| UnfoldOnly of Prims.string Prims.list


let uu___is_Simpl : norm_step  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Simpl -> begin
true
end
| uu____1510 -> begin
false
end))


let uu___is_Weak : norm_step  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Weak -> begin
true
end
| uu____1515 -> begin
false
end))


let uu___is_HNF : norm_step  ->  Prims.bool = (fun projectee -> (match (projectee) with
| HNF -> begin
true
end
| uu____1520 -> begin
false
end))


let uu___is_Primops : norm_step  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Primops -> begin
true
end
| uu____1525 -> begin
false
end))


let uu___is_Delta : norm_step  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Delta -> begin
true
end
| uu____1530 -> begin
false
end))


let uu___is_Zeta : norm_step  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Zeta -> begin
true
end
| uu____1535 -> begin
false
end))


let uu___is_Iota : norm_step  ->  Prims.bool = (fun projectee -> (match (projectee) with
| Iota -> begin
true
end
| uu____1540 -> begin
false
end))


let uu___is_UnfoldOnly : norm_step  ->  Prims.bool = (fun projectee -> (match (projectee) with
| UnfoldOnly (_0) -> begin
true
end
| uu____1548 -> begin
false
end))


let __proj__UnfoldOnly__item___0 : norm_step  ->  Prims.string Prims.list = (fun projectee -> (match (projectee) with
| UnfoldOnly (_0) -> begin
_0
end))


let steps_Simpl : FStar_Syntax_Syntax.term = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.steps_simpl)


let steps_Weak : FStar_Syntax_Syntax.term = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.steps_weak)


let steps_HNF : FStar_Syntax_Syntax.term = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.steps_hnf)


let steps_Primops : FStar_Syntax_Syntax.term = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.steps_primops)


let steps_Delta : FStar_Syntax_Syntax.term = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.steps_delta)


let steps_Zeta : FStar_Syntax_Syntax.term = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.steps_zeta)


let steps_Iota : FStar_Syntax_Syntax.term = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.steps_iota)


let steps_UnfoldOnly : FStar_Syntax_Syntax.term = (FStar_Syntax_Syntax.tdataconstr FStar_Parser_Const.steps_unfoldonly)


let embed_norm_step : FStar_Range.range  ->  norm_step  ->  FStar_Syntax_Syntax.term = (fun rng n1 -> (match (n1) with
| Simpl -> begin
steps_Simpl
end
| Weak -> begin
steps_Weak
end
| HNF -> begin
steps_HNF
end
| Primops -> begin
steps_Primops
end
| Delta -> begin
steps_Delta
end
| Zeta -> begin
steps_Zeta
end
| Iota -> begin
steps_Iota
end
| UnfoldOnly (l) -> begin
(

let uu____1577 = (

let uu____1578 = (

let uu____1579 = (

let uu____1580 = (

let uu____1581 = (embed_list embed_string FStar_Syntax_Syntax.t_string)
in (uu____1581 rng l))
in (FStar_Syntax_Syntax.as_arg uu____1580))
in (uu____1579)::[])
in (FStar_Syntax_Syntax.mk_Tm_app steps_UnfoldOnly uu____1578))
in (uu____1577 FStar_Pervasives_Native.None rng))
end))


let __unembed_norm_step : Prims.bool  ->  FStar_Syntax_Syntax.term  ->  norm_step FStar_Pervasives_Native.option = (fun w t0 -> (

let t = (FStar_Syntax_Util.unmeta_safe t0)
in (

let uu____1604 = (FStar_Syntax_Util.head_and_args t)
in (match (uu____1604) with
| (hd1, args) -> begin
(

let uu____1643 = (

let uu____1656 = (

let uu____1657 = (FStar_Syntax_Util.un_uinst hd1)
in uu____1657.FStar_Syntax_Syntax.n)
in ((uu____1656), (args)))
in (match (uu____1643) with
| (FStar_Syntax_Syntax.Tm_fvar (fv), []) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.steps_simpl) -> begin
FStar_Pervasives_Native.Some (Simpl)
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), []) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.steps_weak) -> begin
FStar_Pervasives_Native.Some (Weak)
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), []) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.steps_hnf) -> begin
FStar_Pervasives_Native.Some (HNF)
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), []) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.steps_primops) -> begin
FStar_Pervasives_Native.Some (Primops)
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), []) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.steps_delta) -> begin
FStar_Pervasives_Native.Some (Delta)
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), []) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.steps_zeta) -> begin
FStar_Pervasives_Native.Some (Zeta)
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), []) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.steps_iota) -> begin
FStar_Pervasives_Native.Some (Iota)
end
| (FStar_Syntax_Syntax.Tm_fvar (fv), ((l, uu____1777))::[]) when (FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.steps_unfoldonly) -> begin
(

let uu____1802 = (

let uu____1807 = (unembed_list unembed_string)
in (uu____1807 l))
in (FStar_Util.bind_opt uu____1802 (fun ss -> (FStar_All.pipe_left (fun _0_44 -> FStar_Pervasives_Native.Some (_0_44)) (UnfoldOnly (ss))))))
end
| uu____1822 -> begin
((match (w) with
| true -> begin
(

let uu____1836 = (

let uu____1837 = (FStar_Syntax_Print.term_to_string t0)
in (FStar_Util.format1 "Not an embedded norm_step: %s" uu____1837))
in (FStar_Errors.warn t0.FStar_Syntax_Syntax.pos uu____1836))
end
| uu____1838 -> begin
()
end);
FStar_Pervasives_Native.None;
)
end))
end))))


let unembed_norm_step : FStar_Syntax_Syntax.term  ->  norm_step FStar_Pervasives_Native.option = (fun t -> (__unembed_norm_step true t))


let unembed_norm_step_safe : FStar_Syntax_Syntax.term  ->  norm_step FStar_Pervasives_Native.option = (fun t -> (__unembed_norm_step false t))


let embed_range : FStar_Range.range  ->  FStar_Range.range  ->  FStar_Syntax_Syntax.term = (fun rng r -> (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_range (r))) FStar_Pervasives_Native.None rng))


let __unembed_range : Prims.bool  ->  FStar_Syntax_Syntax.term  ->  FStar_Range.range FStar_Pervasives_Native.option = (fun w t0 -> (

let t = (FStar_Syntax_Util.unmeta_safe t0)
in (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_constant (FStar_Const.Const_range (r)) -> begin
FStar_Pervasives_Native.Some (r)
end
| uu____1882 -> begin
((match (w) with
| true -> begin
(

let uu____1884 = (

let uu____1885 = (FStar_Syntax_Print.term_to_string t0)
in (FStar_Util.format1 "Not an embedded range: %s" uu____1885))
in (FStar_Errors.warn t0.FStar_Syntax_Syntax.pos uu____1884))
end
| uu____1886 -> begin
()
end);
FStar_Pervasives_Native.None;
)
end)))


let unembed_range : FStar_Syntax_Syntax.term  ->  FStar_Range.range FStar_Pervasives_Native.option = (fun t -> (__unembed_range true t))


let unembed_range_safe : FStar_Syntax_Syntax.term  ->  FStar_Range.range FStar_Pervasives_Native.option = (fun t -> (__unembed_range false t))





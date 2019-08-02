--# -path=.:../abstract:../common

incomplete concrete DocumentationIceFunctor of Documentation = CatIce ** open 
  Terminology,  -- the interface that generates different documentation languages
  ResIce,
  ParadigmsIce,
  (G = GrammarIce),
  (S = SyntaxIce),
  (L = LexiconGer),
  Prelude,
  HTML
in {
flags coding=utf8 ;


lincat
  Inflection = {t : Str; s1,s2 : Str} ;
  Definition = {s : Str} ;
  Document = {s : Str} ;
  Tag = {s : Str} ;

oper
  heading : N -> Str = \n -> (nounHeading n).s ;

lin
  InflectionN, InflectionN2, InflectionN3 = \noun -> {
    t  = "s" ;
    s1 = heading1 (heading noun_Category ++ 
                   case noun.g of {
                     Masc   => "("+heading masculine_Parameter+")" ; 
                     Fem    => "("+heading feminine_Parameter+")" ;
                     Neutr  => "("+heading neuter_Parameter+")"
                   }) ;
    s2 = frameTable ( 
           tr (intagAttr "th" "rowspan=2" "" ++ intagAttr "th" "colspan=2" (heading singular_Parameter) ++ intagAttr "th" "colspan=2" (heading plural_Parameter)) ++
           tr (        th (heading indefinite_Parameter) ++ th (heading definite_Parameter) ++ th (heading indefinite_Parameter) ++ th (heading definite_Parameter)) ++
           tr (th (heading nominative_Parameter) ++ td (noun.s ! Sg ! Free ! Nom) ++ td (noun.s ! Sg ! Suffix ! Nom) ++ td (noun.s ! Pl ! Free ! Nom) ++ td (noun.s ! Pl ! Suffix ! Nom)) ++
           tr (th (heading accusative_Parameter) ++ td (noun.s ! Sg ! Free ! Acc) ++ td (noun.s ! Sg ! Suffix ! Acc) ++ td (noun.s ! Pl ! Free ! Acc) ++ td (noun.s ! Pl ! Suffix ! Acc)) ++
           tr (th (heading dative_Parameter)     ++ td (noun.s ! Sg ! Free ! Dat) ++ td (noun.s ! Sg ! Suffix ! Dat) ++ td (noun.s ! Pl ! Free ! Dat) ++ td (noun.s ! Pl ! Suffix ! Dat)) ++
           tr (th (heading genitive_Parameter)   ++ td (noun.s ! Sg ! Free ! Gen) ++ td (noun.s ! Sg ! Suffix ! Gen) ++ td (noun.s ! Pl ! Free ! Gen) ++ td (noun.s ! Pl ! Suffix ! Gen))
           )
    } ;
{-
  InflectionA, InflectionA2 = \adj ->
    let
      gforms : Degree -> ResGer.Case -> Str = \d,c ->
        td (adj.s ! d ! (AMod (GSg Masc)  c)) ++
        td (adj.s ! d ! (AMod (GSg Fem)   c)) ++
        td (adj.s ! d ! (AMod (GSg Neutr) c)) ++
        td (adj.s ! d ! (AMod GPl         c)) ;
      dtable : Parameter -> Degree -> Str = \s,d ->
        paragraph (heading2 (heading s) ++ frameTable ( 
          tr (th []  ++ th (heading masculine_Parameter) ++ th (heading feminine_Parameter) ++ th (heading neuter_Parameter) ++ 
                        th (heading plural_Parameter)) ++
          tr (th (heading nominative_Parameter) ++ gforms d Nom) ++
          tr (th (heading genitive_Parameter)   ++ gforms d Gen) ++
          tr (th (heading dative_Parameter)     ++ gforms d Dat) ++
          tr (th (heading accusative_Parameter) ++ gforms d Acc) ++
          tr (th (heading predicative_Parameter) ++ intagAttr "td" "colspan=4" (adj.s ! d ! APred))
          ))
    in { t  = "a" ;
         s1 = heading1 (nounHeading adjective_Category).s ;
         s2 = dtable positive_Parameter Posit ++ dtable comparative_Parameter Compar ++ dtable superlative_Parameter Superl
       } ;

  InflectionAdv adv = {
    t  = "adverb" ;
    s1 = heading1 (heading adverb_Category) ;
    s2 = paragraph adv.s
    } ;

  InflectionPrep p = {
    t  = "präp" ;
    s1 = heading1 (heading preposition_Category) ;
    s2 = paragraph (S.mkAdv (lin Prep p) (S.mkNP S.a_Det L.computer_N)).s
    } ;
-}

  InflectionV v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v)) ;
    s2 = inflVerb v
    } ;
{-
  InflectionV2 v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v S.something_NP)) ;
    s2 = inflVerb v
    } ;

  InflectionV3 v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP v S.something_NP S.something_NP)) ;
    s2 = inflVerb v
    } ;

  InflectionV2V v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++
         paragraph (verbExample (S.mkCl S.she_NP (lin V2V v) S.we_NP (S.mkVP (L.sleep_V)))) ;
    s2 = inflVerb v
    } ;

  InflectionV2S v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  InflectionV2Q v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  InflectionV2A v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  InflectionVV v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ++  
         paragraph (verbExample (S.mkCl S.she_NP (lin VV v) (S.mkVP (L.sleep_V)))) ;
    s2 = inflVerb v
    } ;

  InflectionVS v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  InflectionVQ v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;

  InflectionVA v = {
    t  = "v" ;
    s1 = heading1 (heading verb_Category) ;
    s2 = inflVerb v
    } ;
-}

lin
  NoDefinition   t     = {s=t.s};
  MkDefinition   t d   = {s="<p><b>Definierung:</b>"++t.s++d.s++"</p>"};
  MkDefinitionEx t d e = {s="<p><b>Definierung:</b>"++t.s++d.s++"</p><p><b>Beispiel:</b>"++e.s++"</p>"};

  MkDocument d i e = ss (i.s1 ++ d.s ++ i.s2 ++ paragraph e.s) ;  -- explanation appended in a new paragraph
  MkTag i = ss i.t ;

oper 
  verbExample : CatIce.Cl -> Str = \cl ->
     (S.mkUtt cl).s 
     ++ ";" ++ (S.mkUtt (S.mkS S.anteriorAnt cl)).s  --# notpresent
     ;

  inflVerb : Verb -> Str = \verb -> 
     let 
       vfin : VForm -> Str = \f ->
         verb.s ! f ;
       gforms : Voice -> Number -> Person -> Str = \v,n,p -> 
         td (vfin (VPres v Indicative  n p)) ++
         td (vfin (VPres v Subjunctive n p)) ++
         td (vfin (VPast v Indicative  n p)) ++
         td (vfin (VPast v Subjunctive n p)) 
         ;
       voiceTable : Voice -> Str = \voice -> frameTable (
          tr (intagAttr "th" "colspan=2" "" ++ intagAttr "th" "colspan=2" (heading present_Parameter) ++  intagAttr "th" "colspan=2" (heading past_Parameter)) ++  
          tr (intagAttr "th" "colspan=2" "" ++ th (heading indicative_Parameter) ++ th (heading conjunctive_Parameter)  ++  
                       th (heading indicative_Parameter) ++ th (heading conjunctive_Parameter))  ++  
          tr (intagAttr "th" "rowspan=3" (heading singular_Parameter) ++ th "1"  ++ gforms voice Sg P1) ++
          tr (                                                th "2"  ++ gforms voice Sg P2) ++
          tr (                                                th "3"  ++ gforms voice Sg P3) ++
          tr (intagAttr "th" "rowspan=3" (heading plural_Parameter)   ++ th "1"  ++ gforms voice Pl P1) ++
          tr (                                                th "2"  ++ gforms voice Pl P2) ++
          tr (                                                th "3"  ++ gforms voice Pl P3) ++
	  tr (intagAttr "th" "colspan=2" (heading infinitive_Parameter) ++ intagAttr "td" "colspan=4" (vfin (VInf voice))) ++
	  tr (intagAttr "th" "colspan=2" (heading supine_Parameter)     ++ intagAttr "td" "colspan=4" (verb.sup ! voice))
          ) ;
     in
     heading2 (heading active_Parameter) ++ voiceTable Active ++
     heading2 (heading middle_Parameter) ++ voiceTable Middle
     ;
	  
{-
++
        frameTable (
          tr (th (heading imperative_Parameter ++ "Sg.2")  ++ td (vfin (VImper Sg))) ++
          tr (th (heading imperative_Parameter ++ "Pl.2")  ++ td (vfin (VImper Pl))) ++
          tr (th (heading infinitive_Parameter)            ++ td (verb.s ! (VInf False))) ++
          tr (th (heading present_Parameter ++ heading participle_Parameter) ++ td (verb.s ! (VPresPart APred))) ++
          tr (th (heading perfect_Parameter ++ heading participle_Parameter) ++ td (verb.s ! (VPastPart APred))) ++
          tr (th (heading aux_verb_Parameter)       ++ td (case verb.aux of {VHaben => "haben" ; VSein => "sein"}))
        ) ;
-}

}
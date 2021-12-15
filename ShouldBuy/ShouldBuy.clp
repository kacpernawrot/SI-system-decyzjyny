
;;;======================================================
;;;   Automotive Expert System
;;;
;;;     This expert system diagnoses some simple
;;;     problems with a car.
;;;
;;;     CLIPS Version 6.3 Example
;;;
;;;     For use with the Auto Demo Example
;;;======================================================

;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
(deftemplate state-list
   (slot current)
   (multislot sequence))
  
(deffacts startup
   (state-list))
   
;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""

  =>
  
  (assert (UI-state (display WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;;***************
;;;* QUERY RULES *
;;;***************

(defrule determine-engine-state ""

   (logical (start))

   =>

   (assert (UI-state (display StartQuestion)
                     (relation-asserted good-idea-to-buy)
                     (response Tired)
                     (valid-answers Tired TooMuchTV ZeroRespect ILoveMyKids))))
   
   
   
   
(defrule determine-whinning ""

   (logical (good-idea-to-buy Tired))

   =>

   (assert (UI-state (display AreYouAboutToSnap)
                     (relation-asserted whinning)
                     (response NeverToldBefore)
                     (valid-answers NeverToldBefore Yes1 STOPHIM))))

(defrule determine-looks-up ""

   (logical (good-idea-to-buy TooMuchTV))

   =>

   (assert (UI-state (display DoYouMindKidNeverLooksUp)
                     (relation-asserted looks-up)
                     (response Strict)
                     (valid-answers Strict IDontCare))))
                     
(defrule determine-feel-when-drops ""

   (logical (good-idea-to-buy ZeroRespect))

   =>

   (assert (UI-state (display Howyoufeel)
                     (relation-asserted feel-when-drops)
                     (response IDontCare2)
                     (valid-answers IDontCare2 ICurlUpandWeep Fine))))

(defrule determine-one-phone ""

   (logical (good-idea-to-buy ILoveMyKids))

   =>

   (assert (UI-state (display OnePhone)
                     (relation-asserted one-phone)
                     (response OnlyOne)
                     (valid-answers OnlyOne))))
   
(defrule determine-new-year-new-phone ""

   (logical (one-phone OnlyOne))

   =>

   (assert (UI-state (display WhatWillYouDoNextYear)
                     (relation-asserted new-year-new-phone)
                     (response ImATM)
                     (valid-answers ImATM CleanGarage))))

(defrule determine-get-another-phone ""

   (or(logical (feel-when-drops IDontCare2))
   (logical (feel-when-drops ICurlUpandWeep))
   (logical (feel-when-drops Fine))
   (logical (shocked-if-lost IDontCare3))
   (logical (shocked-if-lost StillGetting)))

   =>

   (assert (UI-state (display WillYouBuyNextPhone)
                     (relation-asserted get-another-phone)
                     (response YesIfDeserve)
                     (valid-answers YesIfDeserve NogetJob ImATM))))

(defrule determine-kids-follow-rules ""

   (or(logical (looks-up Strict))
   (logical (answer-urgent-calls IthinkYes)))

   =>

   (assert (UI-state (display DoKidsFollowRules)
                     (relation-asserted kids-follow-rules)
                     (response TheyBetter)
                     (valid-answers TheyBetter OfCourse))))
                     
(defrule determine-handle-losing-phone ""

   (or(logical (looks-up IDontCare))
   (logical (answer-urgent-calls TheyDont)))

   =>

   (assert (UI-state (display CanYouHandleLostPhone)
                     (relation-asserted handle-losing-phone)
                     (response HelpMe)
                     (valid-answers HelpMe Nope))))                     

(defrule determine-know-about-bullying ""

   (logical (whinning Yes1))

   =>

   (assert (UI-state (display DoYouKnowBullying)
                     (relation-asserted know-about-bullying)
                     (response Yeah)
                     (valid-answers Yeah))))

(defrule determine-bankrolling ""

   (logical (whinning STOPHIM))

   =>

   (assert (UI-state (display AreYouBankrolling)
                     (relation-asserted bankrolling)
                     (response PayMost)
                     (valid-answers PayMost MadeOfMoney KidPays))))

(defrule determine-spend-hard-earned-cash ""

   (or(logical (bankrolling PayMost))
   (logical (bankrolling MadeOfMoney))
   )

   =>

   (assert (UI-state (display WhoWillSpendCash)
                     (relation-asserted spend-hard-earned-cash)
                     (response Kid)
                     (valid-answers Kid ImATM))))

(defrule determine-human-child ""

   (or(logical (spend-hard-earned-cash Kid))
   (logical (kids-follow-rules OfCourse))
   )

   =>

   (assert (UI-state (display HumanChild)
                     (relation-asserted human-child)
                     (response Robot)
                     (valid-answers Robot))))

(defrule determine-answer-urgent-calls ""

   (logical (kids-follow-rules TheyBetter))

   =>

   (assert (UI-state (display FastAnswers)
                     (relation-asserted answer-urgent-calls)
                     (response TheyDont)
                     (valid-answers TheyDont IthinkYes))))


(defrule determine-shocked-if-lost ""

   (or(logical (handle-losing-phone HelpMe))
   (logical (handle-losing-phone Nope)))

   =>

   (assert (UI-state (display AreYouShockedOfLostPhone)
                     (relation-asserted shocked-if-lost)
                     (response IDontCare3)
                     (valid-answers IDontCare3 StillGetting))))  

(defrule determine-answer-urgent-calls ""

   (logical (kids-follow-rules TheyBetter))

   =>

   (assert (UI-state (display FastAnswers)
                     (relation-asserted answer-urgent-calls)
                     (response TheyDont)
                     (valid-answers TheyDont IthinkYes))))

(defrule determine-being-bullied ""

   (logical (know-about-bullying Yeah))

   =>

   (assert (UI-state (display AreYouBullied)
                     (relation-asserted being-bullied)
                     (response YesHoldMe)
                     (valid-answers YesHoldMe Littlebit))))

(defrule determine-extra-money-apple ""

   (or(logical (get-another-phone YesIfDeserve))
   (logical (new-year-new-phone CleanGarage)))

   =>

   (assert (UI-state (display MoneyForExtras)
                     (relation-asserted extra-money-apple)
                     (response UnbrekCase)
                     (valid-answers UnbrekCase ImATM))))

(defrule determine-promised-puppy ""

   (logical (being-bullied YesHoldMe))

   =>

   (assert (UI-state (display Puppy)
                     (relation-asserted promised-puppy)
                     (response Idontknowyet)
                     (valid-answers Idontknowyet YesImBestParent))))

(defrule determine-use-as-leverage ""

   (or(logical (being-bullied Littlebit))
   (logical (promised-puppy Idontknowyet)))

   =>

   (assert (UI-state (display Leverage)
                     (relation-asserted use-as-leverage)
                     (response ICanGetHotTub)
                     (valid-answers ICanGetHotTub))))


;;;****************
;;;* REPAIR RULES *
;;;****************

(defrule dont-get-phone-conclusions ""

   (or(logical (whinning NeverToldBefore))
   (logical (get-another-phone NogetJob))
(logical (extra-money-apple UnbrekCase))
   
   )
   
   =>

   (assert (UI-state (display d1)
                     (state final))))
                     
(defrule get-the-phone ""

   (or(logical (new-year-new-phone ImATM))
   (logical (get-another-phone ImATM))
   (logical (spend-hard-earned-cash ImATM))
   (logical (extra-money-apple ImATM))
   (logical (use-as-leverage ICanGetHotTub))
   )
   
   =>

   (assert (UI-state (display d2)
                     (state final))))                     
                     

(defrule why-are-you-asking-conclusions ""

   (or(logical (bankrolling KidPays))
   (logical (promised-puppy YesImBestParent))
   )
   
   =>

   (assert (UI-state (display d3)
                     (state final))))
                     
(defrule buy-kevin-a-phone-conclusions ""

   (or(logical (human-child Robot)))
   
   =>

   (assert (UI-state (display d4)
                     (state final))))









                     
(defrule no-repairs ""

   (declare (salience -10))
  
   (logical (UI-state (id ?id)))
   
   (state-list (current ?id))
     
   =>
  
   (assert (UI-state (display MechanicRepair)
                     (state final))))
                     
;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))
   
(defrule handle-next-response-end-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)
   
   (state-list (sequence ?id $?))
   
   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))
                
   =>
      
   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
      
   (assert (add-response ?id ?response)))   

(defrule handle-add-response

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

(defrule handle-add-response-none

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

(defrule handle-prev

   (declare (salience 10))
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
   

// *** Golem commands ***

BEGIN ~a7!cmd~

IF ~OR(2) !Allegiance(LastTalkedToBy, PC) !Global("MasterOverride", "LOCALS", 1) NextTriggerObject(LastTalkedToBy) !HaveSpellRES("a7!smgl")~ Golem.1
  SAY @45000 /* The golem ignores you completely. */
  IF ~~ EXIT
END

IF ~Allegiance(LastTalkedToBy, PC) OR(2) Global("MasterOverride", "LOCALS", 1) NextTriggerObject(LastTalkedToBy) HaveSpellRES("a7!smgl")~ Golem.2
  SAY @45001 /* The golem awaits your command. */
  + ~!Global("Command", "LOCALS", 0) Allegiance(Myself, FAMILIAR)~ + @45002 /* Follow me! */
      DO ~SetGlobal("Command", "LOCALS", 0)~ EXIT
  + ~!GlobalGT("A7!GolemCount", "GLOBAL", %max_golem_count%)
     !Global("Command", "LOCALS", 0) !Allegiance(Myself, FAMILIAR)~ + @45002 /* Follow me! */
      DO ~IncrementGlobal("A7!GolemCount", "GLOBAL", 1) SetGlobal("CountActive", "LOCALS", 1) SetGlobal("Command", "LOCALS", 0) ChangeEnemyAlly(Myself, FAMILIAR) AddFamiliar()~ EXIT
  + ~GlobalGT("A7!GolemCount", "GLOBAL", %max_golem_count%)
     !Global("Command", "LOCALS", 0) !Allegiance(Myself, FAMILIAR)~ + @45002 /* Follow me! */ + Golem.Limit.Reached

  + ~!Global("Command", "LOCALS", 1) Allegiance(Myself, FAMILIAR)~ + @45003 /* Follow and protect me! */
      DO ~SetGlobal("Command", "LOCALS", 1)~ EXIT
  + ~!GlobalGT("A7!GolemCount", "GLOBAL", %max_golem_count%)
     !Global("Command", "LOCALS", 1) !Allegiance(Myself, FAMILIAR)~ + @45003 /* Follow and protect me! */
      DO ~IncrementGlobal("A7!GolemCount", "GLOBAL", 1) SetGlobal("CountActive", "LOCALS", 1) SetGlobal("Command", "LOCALS", 1) ChangeEnemyAlly(Myself, FAMILIAR) AddFamiliar()~ EXIT
  + ~GlobalGT("A7!GolemCount", "GLOBAL", %max_golem_count%)
     !Global("Command", "LOCALS", 1) !Allegiance(Myself, FAMILIAR)~ + @45003 /* Follow and protect me! */ + Golem.Limit.Reached

  + ~!Global("Command", "LOCALS", 2) !Allegiance(Myself, FAMILIAR)~ + @45004 /* Stand guard! */
      DO ~SetGlobal("Command", "LOCALS", 2) SaveObjectLocation("LOCALS", "Location", Myself) Face(S)~ EXIT
  + ~!Global("Command", "LOCALS", 2) Allegiance(Myself, FAMILIAR)~ + @45004 /* Stand guard! */
      DO ~IncrementGlobal("A7!GolemCount", "GLOBAL", -1) SetGlobal("Command", "LOCALS", 2) RemoveFamiliar() ChangeEnemyAlly(Myself, GOODBUTBLUE) SaveObjectLocation("LOCALS", "Location", Myself) Face(S)~ EXIT

  + ~!Global("Command", "LOCALS", 3) !Allegiance(Myself, FAMILIAR)~ + @45005 /* Stand guard and defend the area! */
      DO ~SetGlobal("Command", "LOCALS", 3) SaveObjectLocation("LOCALS", "Location", Myself) Face(S)~ EXIT
  + ~!Global("Command", "LOCALS", 3) Allegiance(Myself, FAMILIAR)~ + @45005 /* Stand guard and defend the area! */
      DO ~IncrementGlobal("A7!GolemCount", "GLOBAL", -1) SetGlobal("Command", "LOCALS", 3) RemoveFamiliar() ChangeEnemyAlly(Myself, GOODBUTBLUE) SaveObjectLocation("LOCALS", "Location", Myself) Face(S)~ EXIT

  ++ @45006 /* Destroy yourself! */ + Golem.3
  ++ @45007 /* Nevermind. */ EXIT
END

IF ~~ Golem.3
  SAY @45008 /* This action can not be undone. Are you certain? */
  ++ @45009 /* Yes! */ DO ~ApplySpellRES("a7!in01", Myself)~ EXIT
  ++ @45010 /* No! */ EXIT
END

IF ~~ Golem.Limit.Reached
  SAY @45012 /* You cannot have any more golems following you. */
  IF ~~ + Golem.2
END

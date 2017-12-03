part of screeps;

@JS('OK')
external int get _ok;

@JS('ERR_NOT_OWNER')
external int get _errNotOwner;

@JS('ERR_NO_PATH')
external int get _errNoPath;

@JS('ERR_NAME_EXISTS')
external int get _errNameExists;

@JS('ERR_BUSY')
external int get _errBusy;

@JS('ERR_NOT_FOUND')
external int get _errNotFound;

@JS('ERR_NOT_ENOUGH_ENERGY')
external int get _errNotEnoughEnergy;

@JS('ERR_NOT_ENOUGH_RESOURCES')
external int get _errNotEnoughResources;

@JS('ERR_INVALID_TARGET')
external int get _errInvalidTarget;

@JS('ERR_FULL')
external int get _errFull;

@JS('ERR_NOT_IN_RANGE')
external int get _errNotInRange;

@JS('ERR_INVALID_ARGS')
external int get _errInvalidArgs;

@JS('ERR_TIRED')
external int get _errTired;

@JS('ERR_NO_BODYPART')
external int get _errNoBodypart;

@JS('ERR_NOT_ENOUGH_EXTENSIONS')
external int get _errNotEnoughExtensions;

@JS('ERR_RCL_NOT_ENOUGH')
external int get _errRclNotEnough;

@JS('ERR_GCL_NOT_ENOUGH')
external int get _errGclNotEnough;

@JS('FIND_EXIT_TOP')
external int get _findExitsTop;

@JS('FIND_EXIT_RIGHT')
external int get _findExitsRight;

@JS('FIND_EXIT_BOTTOM')
external int get _findExitsBottom;

@JS('FIND_EXIT_LEFT')
external int get _findExitsLeft;

@JS('FIND_EXIT')
external int get _findExits;

@JS('FIND_CREEPS')
external int get _findCreeps;

@JS('FIND_MY_CREEPS')
external int get _findMyCreeps;

@JS('FIND_HOSTILE_CREEPS')
external int get _findHostileCreeps;

@JS('FIND_SOURCES_ACTIVE')
external int get _findSourcesActive;

@JS('FIND_SOURCES')
external int get _findSources;

@JS('FIND_DROPPED_ENERGY')
external int get _findDroppedEnergy;

@JS('FIND_DROPPED_RESOURCES')
external int get _findDroppedResources;

@JS('FIND_STRUCTURES')
external int get _findStructures;

@JS('FIND_MY_STRUCTURES')
external int get _findMyStructures;

@JS('FIND_HOSTILE_STRUCTURES')
external int get _findHostileStructures;

@JS('FIND_FLAGS')
external int get _findFlags;

@JS('FIND_CONSTRUCTION_SITES')
external int get _findConstructionSites;

@JS('FIND_MY_SPAWNS')
external int get _findMySpawns;

@JS('FIND_HOSTILE_SPAWNS')
external int get _findHostileSpawns;

@JS('FIND_MY_CONSTRUCTION_SITES')
external int get _findMyConstructionSites;

@JS('FIND_HOSTILE_CONSTRUCTION_SITES')
external int get _findHostileConstructionSites;

@JS('FIND_MINERALS')
external int get _findMinerals;

@JS('FIND_NUKES')
external int get _findNukes;

final Map<int, Find> _intToFind = {
  _findExitsTop: Find.exitsTop,
  _findExitsRight: Find.exitsRight,
  _findExitsLeft: Find.exitsLeft,
  _findExitsBottom: Find.exitsBottom,
  _findExits: Find.exits,
  _findCreeps: Find.creeps,
  _findMyCreeps: Find.myCreeps,
  _findHostileCreeps: Find.hostileCreeps,
  _findSourcesActive: Find.sourcesActive,
  _findSources: Find.sources,
  _findDroppedEnergy: Find.droppedEnergy,
  _findDroppedResources: Find.droppedResources,
  _findStructures: Find.structures,
  _findMyStructures: Find.myStructures,
  _findHostileStructures: Find.hostileStructures,
  _findFlags: Find.flags,
  _findConstructionSites: Find.constructionSites,
  _findMySpawns: Find.mySpawns,
  _findHostileSpawns: Find.hostileSpawns,
  _findMyConstructionSites: Find.myConstructionSites,
  _findHostileConstructionSites: Find.hostileConstructionSites,
  _findMinerals: Find.minerals,
  _findNukes: Find.nukes
};

@JS('TOP')
external int get _directionTop;

@JS('TOP_RIGHT')
external int get _directionTopRight;

@JS('RIGHT')
external int get _directionRight;

@JS('BOTTOM_RIGHT')
external int get _directionBottomRight;

@JS('BOTTOM')
external int get _directionBottom;

@JS('BOTTOM_LEFT')
external int get _directionBottomLeft;

@JS('LEFT')
external int get _directionLeft;

@JS('TOP_LEFT')
external int get _directionTopLeft;

final Map<int, Direction> _intToDirection = {
  _directionTop: Direction.top,
  _directionTopRight: Direction.topRight,
  _directionRight: Direction.right,
  _directionBottomRight: Direction.bottomRight,
  _directionBottom: Direction.bottom,
  _directionBottomLeft: Direction.bottomLeft,
  _directionLeft: Direction.left,
  _directionTopLeft: Direction.topLeft
};

@JS('COLOR_RED')
external int get _colorRed;

@JS('COLOR_PURPLE')
external int get _colorPurple;

@JS('COLOR_BLUE')
external int get _colorBlue;

@JS('COLOR_CYAN')
external int get _colorCyan;

@JS('COLOR_GREEN')
external int get _colorGreen;

@JS('COLOR_YELLOW')
external int get _colorYellow;

@JS('COLOR_ORANGE')
external int get _colorOrange;

@JS('COLOR_BROWN')
external int get _colorBrown;

@JS('COLOR_GREY')
external int get _colorGrey;

@JS('COLOR_WHITE')
external int get _colorWhite;

final Map<int, Color> _intToColor = {
  _colorRed: Color.red,
  _colorPurple: Color.purple,
  _colorBlue: Color.blue,
  _colorCyan: Color.cyan,
  _colorGreen: Color.green,
  _colorYellow: Color.yellow,
  _colorOrange: Color.orange,
  _colorBrown: Color.brown,
  _colorGrey: Color.grey,
  _colorWhite: Color.white
};

@JS('LOOK_CREEPS')
external String get _lookCreeps;

@JS('LOOK_ENERGY')
external String get _lookDroppedEnergy;

@JS('LOOK_RESOURCES')
external String get _lookDroppedResources;

@JS('LOOK_SOURCES')
external String get _lookSources;

@JS('LOOK_MINERALS')
external String get _lookMinerals;

@JS('LOOK_STRUCTURES')
external String get _lookStructures;

@JS('LOOK_FLAGS')
external String get _lookFlags;

@JS('LOOK_CONSTRUCTION_SITES')
external String get _lookConstructionSites;

@JS('LOOK_NUKES')
external String get _lookNukes;

@JS('LOOK_TERRAIN')
external String get _lookTerrain;

@JS('OBSTACLE_OBJECT_TYPES')
external List<String> get obstacleObjectTypes;

@JS('MOVE')
external String get _bodypartMove;

@JS('WORK')
external String get _bodypartWork;

@JS('CARRY')
external String get _bodypartCarry;

@JS('ATTACK')
external String get _bodypartAttack;

@JS('RANGED_ATTACK')
external String get _bodypartRangedAttack;

@JS('TOUGH')
external String get _bodypartTough;

@JS('HEAL')
external String get _bodypartHeal;

@JS('CLAIM')
external String get _bodypartClaim;

final Map<String, Bodypart> _stringToBodypart = {
  _bodypartMove: Bodypart.move,
  _bodypartWork: Bodypart.work,
  _bodypartCarry: Bodypart.carry,
  _bodypartAttack: Bodypart.attack,
  _bodypartRangedAttack: Bodypart.rangedAttack,
  _bodypartTough: Bodypart.tough,
  _bodypartHeal: Bodypart.heal,
  _bodypartClaim: Bodypart.claim
};

@JS('BODYPART_COST')
external dynamic get _bodypartCostObj;

JsObject<String, int> get _bodypartCost => new JsObject(_bodypartCostObj);

@JS('CREEP_LIFE_TIME')
external int get creepLifeTime;

@JS('CREEP_CLAIM_LIFE_TIME')
external int get creepClaimLifeTime;

@JS('CREEP_CORPSE_RATE')
external num get creepCorpseRate;

@JS('CARRY_CAPACITY')
external int get carryCapacity;

@JS('HARVEST_POWER')
external int get harvestPower;

@JS('HARVEST_MINERAL_POWER')
external int get harvestMineralPower;

@JS('REPAIR_POWER')
external int get repairPower;

@JS('DISMANTLE_POWER')
external int get dismantlePower;

@JS('BUILD_POWER')
external int get buildPower;

@JS('ATTACK_POWER')
external int get attackPower;

@JS('UPGRADE_CONTROLLER_POWER')
external int get upgradeControllerPower;

@JS('RANGED_ATTACK_POWER')
external int get rangedAttackPower;

@JS('HEAL_POWER')
external int get healPower;

@JS('RANGED_HEAL_POWER')
external int get rangedHealPower;

@JS('REPAIR_COST')
external num get repairCost;

@JS('DISMANTLE_COST')
external num get dismantleCost;

@JS('RAMPART_DECAY_AMOUNT')
external int get rampartDecayAmount;

@JS('RAMPART_DECAY_TIME')
external int get rampartDecayTime;

@JS('RAMPART_HITS')
external int get rampartHits;

@JS('RAMPART_HITS_MAX')
external Map<int, int> get rampartHitsMax;

@JS('ENERGY_REGEN_TIME')
external int get energyRegenTime;

@JS('ENERGY_DECAY')
external int get energyDecay;

@JS('SPAWN_HITS')
external int get spawnHits;

@JS('SPAWN_ENERGY_START')
external int get spawnEnergyStart;

@JS('SPAWN_ENERGY_CAPACITY')
external int get spawnEnergyCapacity;

@JS('CREEP_RENEW_TIME')
external int get creepRenewTime;

@JS('SPAWN_RENEW_RATIO')
external num get spawnRenewRatio;

@JS('SOURCE_ENERGY_CAPACITY')
external int get sourceEnergyCapacity;

@JS('SOURCE_ENERGY_NEUTRAL_CAPACITY')
external int get sourceENergyNeutralCapacity;

@JS('SOURCE_ENERGY_KEEPER_CAPACITY')
external int get sourceENergyKeeperCapacity;

@JS('WALL_HITS')
external int get wallHits;

@JS('WALL_HITS_MAX')
external int get wallHitsMax;

@JS('EXTENSION_HITS')
external int get extensionHits;

@JS('EXTENSION_ENERGY_CAPACITY')
external Map<int, int> get extensionEnergyCapacity;

@JS('ROAD_HITS')
external int get roadHIts;

@JS('ROAD_WEAROUT')
external int get roadWearout;

@JS('ROAD_DECAY_AMOUNT')
external int get roadDecayAmount;

@JS('ROAD_DECAY_TIME')
external int get roadDecayTime;

@JS('LINK_HITS')
external int get linkHits;

@JS('LINK_HITS_MAX')
external int get linkHistMax;

@JS('LINK_CAPACITY')
external int get linkCapacity;

@JS('LINK_COOLDOWN')
external int get linkCooldown;

@JS('LINK_LOSS_RATIO')
external num get linkLossRatio;

@JS('STORAGE_CAPACITY')
external int get storageCapacity;

@JS('STORAGE_HITS')
external int get storageHits;

@JS('STRUCTURE_SPAWN')
external String get _structureSpawn;

@JS('STRUCTURE_EXTENSION')
external String get _structureExtension;

@JS('STRUCTURE_ROAD')
external String get _structureRoad;

@JS('STRUCTURE_WALL')
external String get _structureWall;

@JS('STRUCTURE_RAMPART')
external String get _structureRampart;

@JS('STRUCTURE_KEEPER_LAIR')
external String get _structureKeeperLair;

@JS('STRUCTURE_PORTAL')
external String get _structurePortal;

@JS('STRUCTURE_CONTROLLER')
external String get _structureController;

@JS('STRUCTURE_LINK')
external String get _structureLink;

@JS('STRUCTURE_STORAGE')
external String get _structureStorage;

@JS('sTRUCTURE_TOWER')
external String get _structureTower;

@JS('STRUCTURE_OBSERVER')
external String get _structureObserver;

@JS('STRUCTURE_POWER_BANK')
external String get _structurePowerBank;

@JS('STRUCTURE_POWER_SPAWN')
external String get _structurePowerSpawn;

@JS('STRUCTURE_EXTRACTOR')
external String get _structureExtractor;

@JS('STRUCTURE_LAB')
external String get _structureLab;

@JS('STRUCTURE_TERMINAL')
external String get _structureTerminal;

@JS('STRUCTURE_CONTAINER')
external String get _structureContainer;

@JS('STRUCTURE_NUKER')
external String get _structureNuker;

final Map<String, StructureType> _stringToStructureType = {
  _structureContainer: StructureType.container,
  _structureController: StructureType.controller,
  _structureExtension: StructureType.extension,
  _structureExtractor: StructureType.extractor,
  _structureKeeperLair: StructureType.keeperLair,
  _structureLab: StructureType.lab,
  _structureLink: StructureType.link,
  _structureNuker: StructureType.nuker,
  _structureObserver: StructureType.observer,
  _structurePortal: StructureType.portal,
  _structurePowerBank: StructureType.powerBank,
  _structurePowerSpawn: StructureType.powerSpawn,
  _structureRampart: StructureType.rampart,
  _structureRoad: StructureType.road,
  _structureSpawn: StructureType.spawn,
  _structureStorage: StructureType.storage,
  _structureTerminal: StructureType.terminal,
  _structureTower: StructureType.tower,
  _structureWall: StructureType.wall
};

final Map<StructureType, String> _structureTypeToString =
    _reverseMap(_stringToStructureType);

@JS('CONSTRUCTION_COST')
external Map<String, int> get constructionCost;

@JS('CONSTRUCTION_COST_ROAD_SWAMP_RATIO')
external num get constructionCostRoadSwampRatio;

@JS('CONTROLLER_LEVELS')
external Map<int, int> get controllerLevels;

@JS('CONTROLLER_STRUCTURES')
external Map<String, int> get controllerStructures;

@JS('CONTROLLER_DOWNGRADE')
external Map<int, int> get controllerDowngrade;

@JS('CONTROLLER_CLAIM_DOWNGRADE')
external num get controllerClaimDowngrade;

@JS('CONTROLLER_RESERVE')
external int get controllerReserve;

@JS('CONTROLLER_RESERVE_MAX')
external int get controllerReserveMax;

@JS('CONTROLLER_MAX_UPGRADE_PER_TICK')
external int get controllerMaxUpgradePerTick;

@JS('CONTROLLER_ATTACK_BLOCKED_UPGRADE')
external int get controllerAttackBlockedUpgrade;

@JS('CONTROLLER_NUKE_BLOCKED_UPGRADE')
external int get controllerNukeBlockedUpgrade;

@JS('SAFE_MODE_DURATION')
external int get safeModeDuration;

@JS('SAFE_MODE_COOLDOWN')
external int get safeModeCooldown;

@JS('SAFE_MODE_COST')
external int get safeModeCost;

@JS('TOWER_HITS')
external int get towerHits;

@JS('TOWER_CAPACITY')
external int get towerCapacity;

@JS('TOWER_ENERGY_COST')
external int get towerEnergyCost;

@JS('TOWER_POWER_ATTACK')
external int get towerPowerAttack;

@JS('TOWER_POWER_HEAL')
external int get towerPowerHeal;

@JS('TOWER_POWER_REPAIR')
external int get towerPowerRepair;

@JS('TOWER_OPTIMAL_RANGE')
external int get towerOptimalRange;

@JS('TOWER_FALLOFF_RANGE')
external int get towerFalloffRange;

@JS('TOWER_FALLOFFF')
external num get towerFalloff;

@JS('OBSERVER_HITS')
external int get observerHits;

@JS('OBSERVER_RANGE')
external int get observerRange;

@JS('POWER_BANK_HITS')
external int get powerBankHits;

@JS('POWER_BANK_CAPACITY_MAX')
external int get powerBankCapacityMax;

@JS('POWER_BANK_CAPACITY_MIN')
external int get powerBankCapacityMin;

@JS('POWER_BANK_CAPACITY_CRIT')
external num get powerBankCapacityCrit;

@JS('POWER_BANK_DECAY')
external int get powerBankDecay;

@JS('POWER_BANK_HIT_BACK')
external num get powerBankHitBack;

@JS('POWER_SPAWN_HITS')
external int get powerSpawnHits;

@JS('POWER_SPAWN_ENERGY_CAPACITY')
external int get powerSpawnEnergyCapacity;

@JS('POWER_SPAWN_POWER_CAPACITY')
external int get powerSpawnPowerCapacity;

@JS('POWER_SPAWN_ENERGY_RATIO')
external num get powerSpawnEnergyRatio;

@JS('EXTRACTOR_HITS')
external int get extractorHits;

@JS('EXTRACTOR_COOLDOWN')
external int get extractorCooldown;

@JS('LAB_HITS')
external int get labHits;

@JS('LAB_MINERAL_CAPACITY')
external int get labMineralCapacity;

@JS('LAB_ENERGY_CAPACITY')
external int get labEnergyCapacity;

@JS('LAB_BOOST_ENERGY')
external int get labBoostEnergy;

@JS('LAB_BOOST_MINERAL')
external int get labBoostMineral;

@JS('LAB_COOLDOWN')
external int get labCooldown;

@JS('LAB_REACTION_AMOUNT')
external int get labReactionAmount;

@JS('GCL_POW')
external num get gclPow;

@JS('GCL_MULTIPLY')
external int get gclMultiply;

@JS('GCL_NOVICE')
external int get gclNovice;

@JS('TERRAIN_MASK_WALL')
external int get terrainMaskWall;

@JS('TERRAIN_MASK_SWAMP')
external int get terrainMaskSwamp;

@JS('TERRAIN_MASK_LAVA')
external int get terrainMaskLava;

@JS('MAX_CONSTRUCTION_SITES')
external int get maxConstructionSites;

@JS('MAX_CREEP_SIZE')
external int get maxCreepSize;

@JS('MINERAL_REGEN_TIME')
external int get mineralRegenTime;

@JS('MINERAL_MIN_AMOUNT')
external Map<String, int> get mineralMinAmount;

@JS('MINERAL_RANDOM_FACTOR')
external num get mineralRandomFactor;

@JS('MINERAL_DENSITY')
external Map<int, int> get mineralDensity;

@JS('MINERAL_DENSITY_PROBABILITY')
external Map<int, num> get mineralDensityProbability;

@JS('MINERAL_DENSITY_CHANGE')
external num get mineralDensityChange;

@JS('DENSITY_LOW')
external int get densityLow;

@JS('DENSITY_MODERATE')
external int get densityModerate;

@JS('DENSITY_HIGH')
external int get densityHigh;

@JS('DENSITY_ULTRA')
external int get densityUltra;

@JS('TERMINAL_CAPACITY')
external int get terminalCapacity;

@JS('TERMINAL_HITS')
external int get terminalHits;

@JS('TERMINAL_SEND_COST')
external num get terminalSendCost;

@JS('TERMINAL_MIN_SEND')
external int get terminalMinSend;

@JS('TERMINAL_COOLDOWN')
external int get terminalCooldown;

@JS('CONTAINER_HITS')
external int get containerHits;

@JS('CONTAINER_CAPACITY')
external int get containerCapacity;

@JS('CONTAINER_DECAY')
external int get containerDecay;

@JS('CONTAINER_DECAY_TIME')
external int get containerDecayTime;

@JS('CONTAINER_DECAY_TIME_OWNED')
external int get containerDecayTimeOwned;

@JS('NUKER_HITS')
external int get nukerHits;

@JS('NUKER_COOLDOWN')
external int get nukerCooldown;

@JS('NUKER_ENERGY_CAPACITY')
external int get nukerEnergyCapacity;

@JS('NUKER_GHODIUM_CAPACITY')
external int get nukerGhodiumCapacity;

@JS('NUKER_LAND_TIME')
external int get nukerLandTime;

@JS('NUKER_RANGE')
external int get nukerRange;

@JS('NUKER_DAMAGE')
external Map<int, int> get nukerDamage;

@JS('PORTAL_DECAY')
external int get portalDecay;

@JS('ORDER_SELL')
external String get orderSell;

@JS('ORDER_BUY')
external String get orderBuy;

@JS('MARKET_FEE')
external num get marketFee;

@JS('FLAGS_LIMIT')
external int get flagsLimit;

@JS('SUBSCRIPTION_TOKEN')
external String get subscriptionToken;

@JS('RESOURCE_ENERGY')
external String get _resourceEnergy;

@JS('RESOURCE_POWER')
external String get _resourcePower;

@JS('RESOURCE_HYDROGEN')
external String get _resourceHydrogen;

@JS('RESOURCE_OXYGEN')
external String get _resourceOxygen;

@JS('RESOUREC_UTRIUM')
external String get _resourceUtrium;

@JS('RESOURCE_LEMERGIUM')
external String get _resourceLemergium;

@JS('RESOURCE_KEANIUM')
external String get _resourceKeanium;

@JS('RESOURCE_ZYNTHIUM')
external String get _resourceZynthium;

@JS('RESOURCE_CATALYST')
external String get _resourceCatalyst;

@JS('RESOURCE_GHODIUM')
external String get _resourceGhodium;

@JS('RESOURCE_HYDROXIDE')
external String get _resourceHydroxide;

@JS('RESOURCE_ZYNTHIUM_KEANITE')
external String get _resourceZynthiumKeanite;

@JS('RESOURCE_UTRIUM_LEMERGITE')
external String get _resourceUtriumLemergite;

@JS('RESOURCE_UTRIUM_HYDRIDE')
external String get _resourceUtriumHydride;

@JS('RESOURCE_UTRIUM_OXIDE')
external String get _resourceUtriumOxide;

@JS('RESOURCE_KEANIUM_HYDRIDE')
external String get _resourceKeaniumHydride;

@JS('RESOURCE_KEANIUM_OXIDE')
external String get _resourceKeaniumOxide;

@JS('RESOURCE_LEMERGIUM_HYDRIDE')
external String get _resourceLemergiumHydride;

@JS('RESOURCE_LEMERGIUM_OXIDE')
external String get _resourceLemergiumOxide;

@JS('RESOURCE_ZYNTHIUM_HYDRIDE')
external String get _resourceZynthiumHydride;

@JS('RESOURCE_ZYNTHIUM_OXIDE')
external String get _resourceZynthiumOxide;

@JS('RESOURCE_GHODIUM_HYDRIDE')
external String get _resourceGhodiumHydride;

@JS('RESOURCE_GHODIUM_OXIDE')
external String get _resourceGhodiumOxide;

@JS('RESOURCE_UTRIUM_ACID')
external String get _resourceUtriumAcid;

@JS('RESOURCE_UTRIUM_ALAKALIDE')
external String get _resourceUtriumAlkalide;

@JS('RESOURCE_KEANIUM_ACID')
external String get _resourceKeaniumAcid;

@JS('RESOURCE_KEANIUM_ALKALIDE')
external String get _resourceKeaniumAlkalide;

@JS('RESOURCE_LEMERGIUM_ACID')
external String get _resourceLemergiumAcid;

@JS('RESOURCE_LEMERGIUM_ALKALIDE')
external String get _resourceLemergiumAlkalide;

@JS('RESOURCE_ZYNTHIUM_ACID')
external String get _resourceZynthiumAcid;

@JS('RESOURCE_ZYNTHIUM_ALKALIDE')
external String get _resourceZynthiumAlkalide;

@JS('RESOURCE_GHODIUM_ACID')
external String get _resourceGhodiumAcid;

@JS('RESOURCE_GHODIUM_ALKALIDE')
external String get _resourceGhodiumAlkalide;

@JS('RESOURCE_CATALYZED_UTRIUM_ACID')
external String get _resourceCatalyzedUtriumAcid;

@JS('RESOURCE_CATALYZED_UTRIUM_ALAKALIDE')
external String get _resourceCatalyzedUtriumAlkalide;

@JS('RESOURCE_CATALYZED_KEANIUM_ACID')
external String get _resourceCatalyzedKeaniumAcid;

@JS('RESOURCE_CATALYZED_KEANIUM_ALKALIDE')
external String get _resourceCatalyzedKeaniumAlkalide;

@JS('RESOURCE_CATALYZED_LEMERGIUM_ACID')
external String get _resourceCatalyzedLemergiumAcid;

@JS('RESOURCE_CATALYZED_LEMERGIUM_ALKALIDE')
external String get _resourceCatalyzedLemergiumAlkalide;

@JS('RESOURCE_CATALYZED_ZYNTHIUM_ACID')
external String get _resourceCatalyzedZynthiumAcid;

@JS('RESOURCE_CATALYZED_ZYNTHIUM_ALKALIDE')
external String get _resourceCatalyzedZynthiumAlkalide;

@JS('RESOURCE_CATALYZED_GHODIUM_ACID')
external String get _resourceCatalyzedGhodiumAcid;

@JS('RESOURCE_CATALYZED_GHODIUM_ALKALIDE')
external String get _resourceCatalyzedGhodiumAlkalide;

final Map<String, Resource> _stringToResource = {
  _resourceEnergy: Resource.energy,
  _resourcePower: Resource.power,
  _resourceHydrogen: Resource.hydrogen,
  _resourceOxygen: Resource.oxygen,
  _resourceUtrium: Resource.utrium,
  _resourceKeanium: Resource.keanium,
  _resourceLemergium: Resource.lemergium,
  _resourceZynthium: Resource.zynthium,
  _resourceCatalyst: Resource.catalyst,
  _resourceGhodium: Resource.ghodium,
  _resourceHydroxide: Resource.hydroxide,
  _resourceZynthiumKeanite: Resource.zynthiumKeanite,
  _resourceUtriumLemergite: Resource.utriumLemergite,
  _resourceUtriumHydride: Resource.utriumHydride,
  _resourceUtriumOxide: Resource.utriumOxide,
  _resourceKeaniumHydride: Resource.keaniumHydride,
  _resourceKeaniumOxide: Resource.keaniumOxide,
  _resourceLemergiumHydride: Resource.lemergiumHydride,
  _resourceLemergiumOxide: Resource.lemergiumOxide,
  _resourceZynthiumHydride: Resource.zynthiumHydride,
  _resourceZynthiumOxide: Resource.zynthiumOxide,
  _resourceGhodiumHydride: Resource.ghodiumHydride,
  _resourceGhodiumOxide: Resource.ghodiumOxide,
  _resourceUtriumAcid: Resource.utriumAcid,
  _resourceUtriumAlkalide: Resource.utriumAlkalide,
  _resourceKeaniumAcid: Resource.keaniumAcid,
  _resourceKeaniumAlkalide: Resource.keaniumAlkalide,
  _resourceLemergiumAcid: Resource.lemergiumAcid,
  _resourceLemergiumAlkalide: Resource.lemergiumAlkalide,
  _resourceZynthiumAcid: Resource.zynthiumAcid,
  _resourceZynthiumAlkalide: Resource.zynthiumAlkalide,
  _resourceGhodiumAcid: Resource.ghodiumAcid,
  _resourceGhodiumAlkalide: Resource.ghodiumAlkalide,
  _resourceCatalyzedUtriumAcid: Resource.catalyzedUtriumAcid,
  _resourceCatalyzedUtriumAlkalide: Resource.catalyzedUtriumAlkalide,
  _resourceCatalyzedKeaniumAcid: Resource.catalyzedKeaniumAcid,
  _resourceCatalyzedKeaniumAlkalide: Resource.catalyzedKeaniumAlkalide,
  _resourceCatalyzedLemergiumAcid: Resource.catalyzedLemergiumAcid,
  _resourceCatalyzedLemergiumAlkalide: Resource.catalyzedLemergiumAlkalide,
  _resourceCatalyzedZynthiumAcid: Resource.catalyzedZynthiumAcid,
  _resourceCatalyzedZynthiumAlkalide: Resource.catalyzedZynthiumAlkalide,
  _resourceCatalyzedGhodiumAcid: Resource.catalyzedGhodiumAcid,
  _resourceCatalyzedGhodiumAlkalide: Resource.catalyzedGhodiumAlkalide
};

@JS('REACTIONS')
external Map<String, Map<String, String>> get reactions;

@JS('BOOSTS')
external Map<String, Map<String, Map<String, num>>> get boosts;

@JS('PORTAL_UNSTABLE')
external int get portalUnstable;

@JS('PORTAL_MIN_TIMEOUT')
external int get portalMinTimeout;

@JS('PORTAL_MAX_TIMEOUT')
external int get portalMaxTimeout;

@JS('POWER_BANK_RESPAWN_TIME')
external int get powerBankRespawnTime;

@JS('INVADERS_ENERGY_GOAL')
external int get invadersEnergyGoal;

@JS('SYSTEM_USERNAME')
external String get systemUsername;

@JS('SIGN_NOVICE_AREA')
external String get signNoviceArea;

@JS('SIGN_RESPAWN_AREA')
external String get signRespawnArea;

@JS('BODYPARTS_ALL')
external List<String> get _bodypartsAll;

@JS('RESOURCES_ALL')
external List<String> get _resourcesAll;

@JS('COLORS_ALL')
external List<int> get _colorsAll;

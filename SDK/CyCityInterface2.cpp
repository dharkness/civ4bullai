#include "CvGameCoreDLL.h"
#include "CyCity.h"
#include "CyPlot.h"
#include "CyArea.h"
#include "CvInfos.h"

//# include <boost/python/manage_new_object.hpp>
//# include <boost/python/return_value_policy.hpp>

//
// published python interface for CyCity
//
// BUG jdog5000 - start
void CyCityPythonInterface2(python::class_<CyCity>& x)
{
	OutputDebugString("Python Extension Module - CyCityPythonInterface2\n");

	x
// BUG - Building Additional Great People - start
		.def("getAdditionalGreatPeopleRateByBuilding", &CyCity::getAdditionalGreatPeopleRateByBuilding, "int (int /*BuildingTypes*/)")
		.def("getAdditionalBaseGreatPeopleRateByBuilding", &CyCity::getAdditionalBaseGreatPeopleRateByBuilding, "int (int /*BuildingTypes*/)")
		.def("getAdditionalGreatPeopleRateModifierByBuilding", &CyCity::getAdditionalGreatPeopleRateModifierByBuilding, "int (int /*BuildingTypes*/)")
// BUG - Building Additional Great People - end
// BUG - Building Saved Maintenance - start
		.def("getSavedMaintenanceByBuilding", &CyCity::getSavedMaintenanceByBuilding, "int (int /*BuildingTypes*/)")
		.def("getSavedMaintenanceTimes100ByBuilding", &CyCity::getSavedMaintenanceTimes100ByBuilding, "int (int /*BuildingTypes*/)")
// BUG - Building Saved Maintenance - end
// BUG - Building Additional Yield - start
		.def("getAdditionalYieldByBuilding", &CyCity::getAdditionalYieldByBuilding, "int (int /*YieldTypes*/, int /*BuildingTypes*/) - total change of YieldType from adding one BuildingType")
		.def("getAdditionalBaseYieldRateByBuilding", &CyCity::getAdditionalBaseYieldRateByBuilding, "int (int /*YieldTypes*/, int /*BuildingTypes*/) - base rate change of YieldType from adding one BuildingType")
		.def("getAdditionalYieldRateModifierByBuilding", &CyCity::getAdditionalYieldRateModifierByBuilding, "int (int /*YieldTypes*/, int /*BuildingTypes*/) - rate modifier change of YieldType from adding one BuildingType")
// BUG - Building Additional Yield - end
// BUG - Fractional Trade Routes - start
#ifdef _MOD_FRACTRADE
		.def("calculateTradeProfitTimes100", &CyCity::calculateTradeProfitTimes100, "int (CyCity) - returns the unrounded trade profit created by CyCity")
#endif
// BUG - Fractional Trade Routes - end
// BUG - Building Additional Commerce - start
		.def("getAdditionalCommerceByBuilding", &CyCity::getAdditionalCommerceByBuilding, "int (int /*CommerceTypes*/, int /*BuildingTypes*/) - rounded change of CommerceType from adding one BuildingType")
		.def("getAdditionalCommerceTimes100ByBuilding", &CyCity::getAdditionalCommerceTimes100ByBuilding, "int (int /*CommerceTypes*/, int /*BuildingTypes*/) - total change of CommerceType from adding one BuildingType")
		.def("getAdditionalBaseCommerceRateByBuilding", &CyCity::getAdditionalBaseCommerceRateByBuilding, "int (int /*CommerceTypes*/, int /*BuildingTypes*/) - base rate change of CommerceType from adding one BuildingType")
		.def("getAdditionalCommerceRateModifierByBuilding", &CyCity::getAdditionalCommerceRateModifierByBuilding, "int (int /*CommerceTypes*/, int /*BuildingTypes*/) - rate modifier change of CommerceType from adding one BuildingType")
// BUG - Building Additional Commerce - end
// BUG - Production Decay - start
		.def("isBuildingProductionDecay", &CyCity::isBuildingProductionDecay, "bool (int eIndex)")
		.def("getBuildingProductionDecay", &CyCity::getBuildingProductionDecay, "int (int eIndex)")
		.def("getBuildingProductionDecayTurns", &CyCity::getBuildingProductionDecayTurns, "int (int eIndex)")
// BUG - Production Decay - end
// BUG - Production Decay - start
		.def("getUnitProductionTime", &CyCity::getUnitProductionTime, "int (int eIndex)")
		.def("setUnitProductionTime", &CyCity::setUnitProductionTime, "int (int eIndex, int iNewValue)")
		.def("changeUnitProductionTime", &CyCity::changeUnitProductionTime, "int (int eIndex, int iChange)")
		.def("isUnitProductionDecay", &CyCity::isUnitProductionDecay, "bool (int eIndex)")
		.def("getUnitProductionDecay", &CyCity::getUnitProductionDecay, "int (int eIndex)")
		.def("getUnitProductionDecayTurns", &CyCity::getUnitProductionDecayTurns, "int (int eIndex)")
// BUG - Production Decay - end
		;
}
// BUG jdog5000 - end
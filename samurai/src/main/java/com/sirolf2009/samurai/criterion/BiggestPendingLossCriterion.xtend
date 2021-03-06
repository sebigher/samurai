package com.sirolf2009.samurai.criterion

import com.sirolf2009.samurai.indicator.IndicatorPendingLoss
import eu.verdelhan.ta4j.TimeSeries
import eu.verdelhan.ta4j.Trade
import eu.verdelhan.ta4j.TradesRecord
import eu.verdelhan.ta4j.analysis.criteria.AbstractAnalysisCriterion

class BiggestPendingLossCriterion extends AbstractAnalysisCriterion {
	
	override calculate(TimeSeries series, TradesRecord tradingRecord) {
		tradingRecord.map[calculate(series, it)].max()
	}

	override calculate(TimeSeries series, Trade trade) {
		val pendingProfit = new IndicatorPendingLoss(series, trade)
		return (trade.entry.index .. trade.exit.index).map[pendingProfit.getValue(it).toDouble].max()
	}

	override betterThan(double criterionValue1, double criterionValue2) {
		return criterionValue1 < criterionValue2
	}
	
}
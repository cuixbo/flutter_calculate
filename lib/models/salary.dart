class Salary {
  var salaryBefore;
  var salaryAfter;
  var social;
  var funds;
  var taxAmount;
  var tax;
  var taxThreshold;
  TaxRate taxRate;

  Salary({
    this.salaryBefore,
    this.salaryAfter,
    this.social,
    this.funds,
    this.taxAmount,
    this.tax,
    this.taxThreshold,
    this.taxRate,
  });

  @override
  String toString() {
    return 'Salary{salaryBefore: $salaryBefore, salaryAfter: $salaryAfter, social: $social, funds: $funds, taxAmount: $taxAmount, tax: $tax, taxThreshold: $taxThreshold, taxRate: $taxRate}';
  }
}

////   3%  0
//   10% 210
//   20% 1410
//   25% 2660
//   30% 4410
//   35% 7160
//   45% 15160
class TaxRate {
  static final zero = TaxRate(0, '未达到起征点', 0, 0);
  static final one = TaxRate(1, '不超过3,000元', 0.03, 0);
  static final two = TaxRate(2, '超过3,000元至12,000元', 0.10, 210);
  static final three = TaxRate(3, '超过12,000元至25,000元	', 0.20, 1410);
  static final four = TaxRate(4, '超过25,000元至35,000元', 0.25, 2660);
  static final five = TaxRate(5, '超过35,000元至55,000元', 0.30, 4410);
  static final six = TaxRate(6, '超过55,000元至80,000元	', 0.35, 7160);
  static final seven = TaxRate(7, '超过80,000元', 0.45, 15160);

  static final List rates = [one, two, three, four, five, six, seven];

  TaxRate(
      this.level, this.amountRange, this.rate, this.quickDeduction);

  final int level;
  final String amountRange;
  final num rate;
  final num quickDeduction;

  static TaxRate whichTaxRate(num taxAmount) {
    if (taxAmount <= 0) {
      return TaxRate.zero;
    } else if (taxAmount <= 3000) {
      return TaxRate.one;
    } else if (taxAmount < 12000) {
      return TaxRate.two;
    } else if (taxAmount < 25000) {
      return TaxRate.three;
    } else if (taxAmount < 35000) {
      return TaxRate.four;
    } else if (taxAmount < 55000) {
      return TaxRate.five;
    } else if (taxAmount < 80000) {
      return TaxRate.six;
    } else {
      return TaxRate.seven;
    }
  }

  @override
  String toString() {
    return 'TaxRate{level: $level, taxAmountRange: $amountRange, taxRate: $rate, taxQuickDeduction: $quickDeduction}';
  }
}

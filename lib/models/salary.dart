class Salary {
  var salaryBefore;
  var salaryAfter;
  var social;
  var funds;

  var taxAmount;

  var tax;

  var taxThreshold;
  var taxRate;
  var taxQuickDeduction;

  Salary(
      {this.salaryBefore,
      this.salaryAfter,
      this.social,
      this.funds,
      this.taxAmount,
      this.tax,
      this.taxThreshold,
      this.taxRate,
      this.taxQuickDeduction});

  @override
  String toString() {
    return 'Salary{salaryBefore: $salaryBefore, salaryAfter: $salaryAfter, social: $social, funds: $funds, taxAmount: $taxAmount, tax: $tax, taxThreshold: $taxThreshold, taxRate: $taxRate, taxQuickDeduction: $taxQuickDeduction}';
  }


}

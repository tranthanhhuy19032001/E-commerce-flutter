import 'package:flutter/material.dart';

/// The CheckoutPage widget is a stateless widget resembling your typical
/// checkout page and some typical option along with some helpful features
/// such as built-in form validation and credit card icons that update
/// based on the input provided.
/// This is a UI widget only and holds no responsibility and makes no guarantee
/// for transactions using this ui. Transaction security and integrity is
/// the responsibility of the developer and what ever Third-party transaction
/// api that developer is using. A great API to use is Stripe
class CheckoutPage extends StatelessWidget {
  /// The CheckoutPage widget is a stateless widget resembling your typical
  /// checkout page and some typical option along with some helpful features
  /// such as built-in form validation and credit card icons that update
  /// based on the input provided.
  /// This is a UI widget only and holds no responsibility and makes no guarantee
  /// for transactions using this ui. Transaction security and integrity is
  /// the responsibility of the developer and what ever Third-party transaction
  /// api that developer is using. A great API to use is Stripe
  const CheckoutPage(
      {Key? key,
      required this.priceItems,
      required this.payToName,
      this.displayNativePay = false,
      this.isApple = false,
      this.onNativePay,
      this.displayCashPay = false,
      this.onCashPay,
      this.displayEmail = true,
      this.lockEmail = false,
      this.initEmail = '',
      this.initPhone = '',
      this.initBuyerName = '',
      this.countriesOverride,
      this.onBack,
      this.formKey,
      this.cashPrice,
      this.displayTestData = false,
      this.footer})
      : assert(priceItems.length <= 10),
        super(key: key);

  /// The list of items with prices [PriceItem]'s to be shown within the
  /// drop down banner on the checkout page
  final List<PriceItem> priceItems;

  /// If you are providing a cash option at a discount, provide its price
  /// ex: 12.99
  final double? cashPrice;

  /// Provide the name of the vendor handling the transaction or recieving the
  /// funds from the user during this transaction
  final String payToName;

  /// should you display native pay option?
  final bool displayNativePay;

  /// is this the user on an apple based platform?
  final bool isApple;

  /// Provide a function that will be triggered once the user clicks on the
  /// native button. Can be left null if native option is not to be displayed
  final Function? onNativePay;

  /// Should the cash option appear?
  final bool displayCashPay;

  /// Provide a function that should trigger if the user presses the cash
  /// option. Can be left null if Cash option is not to be displayed
  final Function? onCashPay;

  /// Should the email box be displayed?
  final bool displayEmail;

  /// Should the email form field be locked? This should only be done if an
  /// [initEmail] is provided
  final bool lockEmail;

  /// Provide an email if you have it, to prefill the email field on the Credit
  /// Card form
  final String initEmail;

  /// Provide a name if you have it, to prefill the name field on the Credit
  /// Card form
  final String initBuyerName;

  /// Provide a phone number if you have it, to prefill the name field on the
  /// Credit Card form
  final String initPhone;

  /// If you have a List of Countries that you would like to use to override the
  /// currently provide list of 1, being 'United States', add the list here.
  /// Warning: The credit card form does not currently adjust based on selected
  /// country's needs to verify a card. This form may not work for all countries
  final List<String>? countriesOverride;

  /// If you would like to provide an integraded back button in the header, add
  /// add the needed functionality here.
  /// ex) onBack : ()=>Navigator.of(context).pop();
  final Function? onBack;

  /// You will need to provide a general [FormState] key to control, validate
  /// and save the form data based on your needs.
  final GlobalKey<FormState>? formKey;

  /// If you would like to display test data during your development, a dataset
  /// based on Stripe test data is provided. To use this date, simply mark this
  /// true.
  /// WARNING: Make sure to mark false for any release
  final bool displayTestData;

  /// Provide a footer to end the checkout page using any desired widget or
  /// use our built-in [CheckoutPageFooter]
  final Widget? footer;

  /// getter to determine whether or not to display divider above the cash button
  bool get _displayOrCash => displayNativePay && displayCashPay;

  /// getter to determine whether or not to display divider above the card button
  bool get _displayOrCard => displayNativePay || displayCashPay;

  /// getter to determine whether or not to display a discounted cash price
  bool get _displayCashPrice => displayCashPay && (cashPrice != null);

  @override
  Widget build(BuildContext context) {
    // some ui sizing variables
    const double _spacing = 30.0;
    const double _padding = 18.0;
    const double _dividerThickness = 1.2;
    const double _collapsedAppBarHeight = 100;

    // reference to whether or not the sliverAppBar is open or closed
    bool _isOpen = false;

    // Calculate the total charge amount
    int _priceCents = 0;
    for (var item in priceItems) {
      _priceCents += item.totalPriceCents;
    }

    // create a new list of items
    final List<PriceItem> _priceItems = priceItems;

    // add the final price as a line item
    _priceItems.add(
        PriceItem(name: 'Total', quantity: 1, totalPriceCents: _priceCents));

    // convert the calculated total to a string
    final String _priceString =
        (_priceCents.toDouble() / 100).toStringAsFixed(2);

    // calculate the height of the expanded appbar based on the total number
    // of line items to display.
    final double _expHeight = (_priceItems.length * 50) + 165;

    // Calculate the init height the scroll should be set to to properly
    // display the title and amount to be charged
    final double _initHeight = _expHeight - (_collapsedAppBarHeight + 30.0);

    // create a ScrollController to listen to whether or not the appbar is open
    final ScrollController _scrollController =
        ScrollController(initialScrollOffset: _initHeight);

    // create a key to modify the details text based on appbar expanded status
    final GlobalKey<_StatefullWrapperState> textKey =
        GlobalKey<_StatefullWrapperState>();

    // set the text that should be display based on the appbar status
    const Widget textWhileClosed = Text(
      'View Details',
      style: TextStyle(fontSize: 12.0),
    );
    const Widget textWhileOpen = Text(
      'Hide Details',
      style: TextStyle(fontSize: 12.0),
    );

    // add the listener to the scroll controller mentioned above
    _scrollController.addListener(() {
      final bool result = (_scrollController.offset <= (2 * _initHeight / 3));
      if (result != _isOpen) {
        _isOpen = result;
        if (_isOpen) {
          textKey.currentState?.setchild(textWhileOpen);
        } else {
          textKey.currentState?.setchild(textWhileClosed);
        }
      }
    });

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          snap: false,
          pinned: false,
          floating: false,
          backgroundColor: Colors.grey.shade50,
          collapsedHeight: _collapsedAppBarHeight,
          // set to false to prevent undesired back arrow
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              SizedBox(
                width: 40,
                child: (onBack != null)
                    ? IconButton(
                        onPressed: () => onBack!(),
                        icon: const Icon(
                          Icons.keyboard_arrow_left_outlined,
                          color: Colors.black,
                        ))
                    : null,
              ),
              Expanded(
                  child: Text(
                payToName.length < 16 ? '$payToName Checkout' : payToName,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 26, color: Colors.black),
              )),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size(120.0, 32.0),
            child: GestureDetector(
              onTap: () {
                if (_isOpen) {
                  _scrollController.jumpTo(_initHeight);
                } else {
                  _scrollController.jumpTo(0);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Charge Amount '),
                  Text(
                    '\$$_priceString',
                    style: const TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  _StatefullWrapper(
                    key: textKey,
                    initChild: textWhileClosed,
                  ),
                ],
              ),
            ),
          ),
          expandedHeight: _expHeight,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 80, 16.0, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: _priceItems
                        .map(
                            (priceItem) => _PriceListItem(priceItem: priceItem))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.all(20)),
                            Text("Location:")
                          ],
                        )
                      ],
                    ),
                    if (displayNativePay) const SizedBox(height: _spacing * 2),
                    if (displayNativePay)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 200, 43, 98),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          if (onNativePay != null) {
                            onNativePay!();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Image.asset(
                                'assets/images/momo.png',
                              ),
                            ),
                            Text(
                              'Pay',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: isApple
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    if (_displayOrCash)
                      const SizedBox(
                        height: _spacing,
                      ),
                    if (_displayOrCash)
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: _dividerThickness,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: _padding),
                            child: Text('Or pay with Cash'),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: _dividerThickness,
                            ),
                          ),
                        ],
                      ),
                    if (displayCashPay) const SizedBox(height: _spacing),
                    if (displayCashPay)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          if (onCashPay != null) {
                            onCashPay!();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              height: 32,
                              width: 32,
                              // child: Image.asset(
                              //     'assets/images/pay_option_cash.png',
                              //     package: 'checkout_screen_ui'),
                            ),
                            Text(
                              'Cash',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: isApple
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    if (_displayCashPrice)
                      const Padding(
                        padding: EdgeInsets.only(top: 12.0, bottom: 8.0),
                        child: Text(
                          'Discounted price of',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                              fontSize: 12),
                        ),
                      ),
                    if (_displayCashPrice)
                      Text(
                        '\$${cashPrice!.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.grey),
                      ),
                    if (_displayOrCard)
                      const SizedBox(
                        height: _spacing,
                      ),
                    if (_displayOrCard)
                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: _dividerThickness,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: _spacing,
                    ),
                    footer ?? const SizedBox(height: 120),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Private and simple class meant to wrap a stateless widget
class _StatefullWrapper extends StatefulWidget {
  const _StatefullWrapper({Key? key, required this.initChild})
      : super(key: key);
  final Widget initChild;

  @override
  _StatefullWrapperState createState() => _StatefullWrapperState();
}

class _StatefullWrapperState extends State<_StatefullWrapper> {
  late Widget child;

  setchild(Widget newChild) {
    setState(() {
      child = newChild;
    });
  }

  @override
  void initState() {
    super.initState();
    child = widget.initChild;
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

/// Class object containing required information to display in the checkout
///
/// This class holds the name, description, quantity and cost of items to be
/// displayed on the drop down menu within the checkout page.
class PriceItem {
  /// Class object containing required information to display in the checkout
  ///
  /// This class holds the name, description, quantity and cost of items to be
  /// displayed on the drop down menu within the checkout page.
  PriceItem(
      {required this.name,
      this.description,
      required this.quantity,
      required this.totalPriceCents});

  /// The name of the item to be displayed at checkout
  /// ex: 'Product A'
  final String name;

  /// The optional description of the item to be displayed at checkout
  /// ex: 'additional information about product'
  final String? description;

  /// the quantity of the item to be display at checkout
  /// ex: 1
  final int quantity;

  /// The total cost of the line item as cents to be display at checkout
  /// ex: 1299  => this represent $12.99
  final int totalPriceCents;

  /// getter for the price as string with no dollar sign included
  /// ex: returns => '12.99'
  String get price => (totalPriceCents.toDouble() / 100.00).toStringAsFixed(2);

  @override
  String toString() {
    return 'PriceItem [ name: $name, description: $description, quantity: $quantity, totalPriceCents: $totalPriceCents ]';
  }
}

/// Private stateless widget used to display a line item for each product
/// line item
class _PriceListItem extends StatelessWidget {
  const _PriceListItem({Key? key, required this.priceItem}) : super(key: key);

  final PriceItem priceItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    priceItem.name,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: (priceItem.quantity == 1)
                      ? Container()
                      : Text(
                          'x${priceItem.quantity}',
                        ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '\$${priceItem.price}',
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            (priceItem.description != null && priceItem.description!.isNotEmpty)
                ? Row(
                    children: [
                      Text(
                        priceItem.description!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 16,
                  ),
          ],
        ),
      ),
    );
  }
}

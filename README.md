# Project Q
A Dynamic [SOQL Query](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_sosl_intro.htm) Builder for the [Force.com Platform](https://developer.salesforce.com/docs/atlas.en-us.fundamentals.meta/fundamentals/adg_preface.htm)

  [![CircleCI Build Status](https://circleci.com/gh/jpmonette/q.png?style=shield&circle-token=:circle-token)](https://circleci.com/gh/jpmonette/q)

> ***WARNING:*** Both the documentation and the package itself is under heavy
> development and in a very early stage. That means, this repo is full of
> untested code and the API can break without any further notice. Therefore,
> it comes with absolutely no warranty at all. Feel free to browse or even
> contribute to it :)

## Installation

Deploy the Apex classes from the `./src/classes/` repository into your Salesforce project.

## Usage

```java
Q query = new Q(Account.SObjectType)
    .selectFields(SObjectType.Account.fieldSets.Example)
    .addSubquery(new Q('Contacts'))
    .add(Q.condition('Name').isLike('%Acme%'))
    .add(Q.condition('BillingCountry').isNotNull())
    .addLimit(5);

System.debug(query.toSOQL());
// SELECT CreatedById, Description, Owner.Email, (SELECT Id FROM Contacts) FROM Account WHERE Name LIKE '%Acme%' AND BillingCountry != null LIMIT 5
```

While chaining methods is a convenient way to initialise your query, you also have the ability to manually build complex queries depending on specific conditions.

```java
Q query = new Q(Contact.SObjectType).addLimit(5);

if (String.isNotBlank(firstName)) {
  query.add(Q.condition('FirstName').equals(firstName))
}

if (String.isNotBlank(lastName)) {
  query.add(Q.condition('LastName').equals(lastName))
}

System.debug(query.toSOQL());
// SELECT Id FROM Contact WHERE FirstName = 'Céline' AND LastName = 'Dion' LIMIT 5
```

## Roadmap

This library is being initially developed for one of my internal project,
so API methods will likely be implemented in the order that they are
needed by my project. Eventually, I would like to cover the entire
SOQL and SOSL query language, so contributions are of course
[always welcome][contributing]. Adding new methods is relatively
straightforward, so feel free to join the fun!

[contributing]: CONTRIBUTING.md


## License

This library is distributed under the MIT license found in the [LICENSE](./LICENSE)
file.

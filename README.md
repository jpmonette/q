# Project Q
A Dynamic [SOQL Query](https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql_sosl_intro.htm) Builder for the [Force.com Platform](https://developer.salesforce.com/docs/atlas.en-us.fundamentals.meta/fundamentals/adg_preface.htm)

 [![Build Status](https://travis-ci.com/fehays/q.svg?branch=master)](https://travis-ci.com/fehays/q)
 [![Coverage Status](https://coveralls.io/repos/github/fehays/q/badge.svg?branch=master)](https://coveralls.io/github/fehays/q?branch=master)
  [![Maintainability](https://api.codeclimate.com/v1/badges/bb48ebe88349e1272759/maintainability)](https://codeclimate.com/github/fehays/q/maintainability)

## Installation

Deploy the Apex classes from the `./force-app/main/default/classes/` repository into your Salesforce project.

## Basic Usage

```java
Q query = new Q(Account.SObjectType)
    .selectFields(SObjectType.Account.fieldSets.Example)
    .addSubquery(new Q('Contacts'))
    .add(Q.condition('Name').isLike('%Acme%'))
    .add(Q.condition('BillingCountry').isNotNull())
    .addLimit(5);

System.debug(query.build());
// SELECT CreatedById, Description, Owner.Email, (SELECT Id FROM Contacts) FROM Account WHERE Name LIKE '%Acme%' AND BillingCountry != null LIMIT 5
```

While chaining methods is a convenient way to initialise your query, you also have the ability to manually build complex queries depending on specific conditions.

```java
Q query = new Q(Contact.SObjectType).addLimit(5);

if (String.isNotBlank(firstName)) {
  query.add(Q.condition('FirstName').equalsTo(firstName))
}

if (String.isNotBlank(lastName)) {
  query.add(Q.condition('LastName').equalsTo(lastName))
}

System.debug(query.build());
// SELECT Id FROM Contact WHERE FirstName = 'Céline' AND LastName = 'Dion' LIMIT 5
```

## Bind Variables
```java
String accountName = '%Acme%';
Q query = new Q(Account.SObjectType)
    .selectFields('Id')
    .add(Q.condition('Name').isLike(Q.bindVar(':accountName')));

System.debug(query.build());
// SELECT Id FROM Account WHERE Name LIKE :accountName
```

## Parenthetical Groups
```java
Q query =
new Q(Account.SObjectType)
  .add(Q.orGroup()
    .add(Q.condition('Name').isEqualTo('Acme 1'))
    .add(Q.condition('Name').isEqualTo('Acme 2')))

System.debug(query.build());
//SELECT Id FROM Account WHERE (Name = 'Acme 1' OR Name = 'Acme 2')
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

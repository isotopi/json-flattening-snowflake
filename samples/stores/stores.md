## JSON Structure Overview

```jsonc
// Level 0: Root object
{
    "store": {                                        // Level 1: Store object
        "details": {                                  //   Level 2: Store details
            "name": "string",                         //     Level 3: Store name
            "location": {                             //     Level 3: Store location
                "address": {                          //       Level 4: Address details
                    "street": "string",               //         Level 5: Street address
                    "suite": "string",                //         Level 5: Suite number
                    "city": "string",                 //         Level 5: City
                    "state": "string",                //         Level 5: State
                    "zipCode": "string",              //         Level 5: ZIP code
                    "country": "string"               //         Level 5: Country
                },
                "coordinates": {                      //       Level 4: Geographic coordinates
                    "latitude": number,               //         Level 5: Latitude
                    "longitude": number,              //         Level 5: Longitude
                    "geoDetails": {                   //         Level 5: Additional geographic details
                        "elevation": number,          //           Level 6: Elevation
                        "timezone": "string",         //           Level 6: Timezone
                        "utcOffset": "string",        //           Level 6: UTC offset
                        "climate": {                  //           Level 6: Climate information
                            "averageTemperature": {
                                "summer": number,     //             Level 7: Summer temperature
                                "winter": number      //             Level 7: Winter temperature
                            },
                            "precipitation": {
                                "annual": number,     //             Level 7: Annual precipitation
                                "monthly": {          //             Level 7: Monthly precipitation
                                    "January": number,
                                    "February": number,
                                    "March": number,
                                    "April": number,
                                    "May": number,
                                    "June": number,
                                    "July": number,
                                    "August": number,
                                    "September": number,
                                    "October": number,
                                    "November": number,
                                    "December": number
                                }
                            }
                        }
                    }
                }
            }
        },

        "contact": {                                  //   Level 2: Contact information
            "info": {
                "email": "string",                    //     Level 3: Support email
                "phone": "string"                     //     Level 3: Support phone
            },
            "socialMedia": {
                "platforms": {
                    "facebook": {
                        "url": "string",
                        "followers": number,
                        "engagement": {
                            "likes": number,
                            "shares": number,
                            "comments": number
                        }
                    },
                    "twitter": {
                        "handle": "string",
                        "followers": number,
                        "engagement": {
                            "retweets": number,
                            "likes": number,
                            "replies": number
                        }
                    },
                    "instagram": {
                        "url": "string",
                        "followers": number,
                        "engagement": {
                            "likes": number,
                            "comments": number,
                            "shares": number
                        }
                    },
                    "youtube": {
                        "channel": "string",
                        "subscribers": number,
                        "videos": {
                            "list": [
                                {
                                    "title": "string",
                                    "views": number,
                                    "likes": number,
                                    "comments": number
                                }
                            ]
                        }
                    }
                }
            }
        },

        "inventory": {                                //   Level 2: Inventory information
            "products": [
                {
                    "id": number,                     //     Level 3: Product ID
                    "details": {
                        "name": "string",                 //       Level 4: Product name
                        "category": "string",             //       Level 4: Product category
                        "price": number,                  //       Level 4: Product price
                        "stock": {
                            "quantity": number,               //         Level 5: Quantity in stock
                            "warehouse": {
                                "location": "string",
                                "lastRestocked": "string",
                                "manager": {
                                    "name": "string",
                                    "contact": {
                                        "email": "string",
                                        "phone": "string"
                                    }
                                }
                            }
                        },
                        "ratings": {
                            "average": number,                //         Level 5: Average rating
                            "reviews": {
                                "total": number,
                                "detailed": {
                                    "stars5": number,
                                    "stars4": number,
                                    "stars3": number,
                                    "stars2": number,
                                    "star1": number
                                }
                            }
                        },
                        "specifications": {
                            "brand": "string",
                            "features": ["string"],
                            "warranty": {
                                "period": "string",
                                "type": "string",
                                "conditions": {
                                    "coverage": "string",
                                    "exceptions": ["string"]
                                }
                            },
                            "dimensions": {
                                "weight": "string",
                                "size": {
                                    "width": "string",
                                    "height": "string",
                                    "depth": "string"
                                }
                            },
                            "battery": {
                                "type": "string",
                                "capacity": "string",
                                "chargingTime": "string"
                            }
                        }
                    },
                    "relatedProducts": [number],        //     Level 4: Related product IDs
                    "discounts": {
                        "list": [
                            {
                                "type": "string",
                                "value": number,
                                "startDate": "string",
                                "endDate": "string"
                            }
                        ]
                    }
                }
            ]
        },

        "events": {                                   //   Level 2: Store events
            "list": [
                {
                    "eventId": number,                //     Level 3: Event ID
                    "name": "string",                 //     Level 3: Event name
                    "date": "string",                 //     Level 3: Event date
                    "location": "string",             //     Level 3: Event location
                    "description": "string"           //     Level 3: Event description
                }
            ]
        }
    }
}
```
# MLS Activity Processor

The MLS Activity Processor is a rails-based api which is used to browse and
explore the Toronto Municipal Licensing Standards data (available via Toronto
Open Data).

The main intention behind this dataset is to help users find the worst offender
rental buildings in the City of Toronto.

The mls data is at:

This is an-api only application. It does not provide a frontend.

## Future features

- [ ] Intake an address
- [ ] Allow user to get paginated list of worst offenders (by address)
- [ ] Intake the inspection activity
- [ ] Intake the deficiencies reported
- [ ] Geo-code addresses
- [ ] Allow users to do a chunked upload of the MLS dataset zipfile

## API endpoints

### Import addresses
```
POST /address/import
<csv content>
Result: { { id: 1, address: "12 Billings" }, { id: 2, address: "15 Donaldson St. } }
```


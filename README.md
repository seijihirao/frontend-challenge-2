# DieselBank - Frontend Challenge

This is a fork of diesel's frontend challenge with a solution

## Run

First create a `.env` file on the root of the project with the following structure

```yaml
# API KEYS
GOOGLE_PLACES_API_KEY={MYAPIKEY}
OPENWEATHER_API_KEY={MYAPIKEY}
```

> Ovewrite `{MYAPIKEY}` with your respective api keys

Then run flutter with

```sh
$ flutter pub get
$ flutter run
```

## Design

It was used the given figma as a base, but the final design approach was more cartoony.

<video width="120" height="240" autoplay>
  <source src="https://user-images.githubusercontent.com/10869375/145488105-36ecdf8a-a5b9-454e-b941-c38396f87610.mov">
</video>

## Development

 * Project Tasks - [Github Projects](https://github.com/seijihirao/frontend-challenge-2/projects/1)
 * Branching - `dev` and `main`

## Libraries
 
 * State Manager - [provider](https://pub.dev/packages/provider)
 
## APIs

 * Weather - [OpenWeather](https://openweathermap.org/)
 * Cities autocomplete - [Google Places](https://developers.google.com/maps/documentation/places/web-service/overview)

> It should have been used openweather's city list json on a CDN instead of google places, as it 
would have more confiability
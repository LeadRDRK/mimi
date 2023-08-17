/// Meta information about the instance.
/// 
/// Some properties in newer versions are not included.
class Meta {
  final String? maintainerName;
  final String? maintainerEmail;
  final String version;
  final String name;
  final String uri;
  final String? description;
  final List<String> langs;
  final String? tosUrl;
  final String repositoryUrl;
  final String feedbackUrl;
  final String? defaultDarkTheme;
  final String? defaultLightTheme;
  final bool disableRegistration;
  final bool cacheRemoteFiles;
  final bool cacheRemoteSensitiveFiles;
  final bool emailRequiredForSignup;
  final bool enableHcaptcha;
  final String? hcaptchaSiteKey;
  final bool enableRecaptcha;
  final String? recaptchaSiteKey;
  final bool enableTurnstile;
  final String? turnstileSiteKey;
  final String? swPublickey;
  final String mascotImageUrl;
  final String bannerUrl;
  final String? serverErrorImageUrl;
  final String? infoImageUrl;
  final String? notFoundImageUrl;
  final String? iconUrl;
  final num maxNoteTextLength;
  final bool? requireSetup; 
  final bool enableEmail; 
  final bool enableServiceWorker; 
  final bool translatorAvailable; 
  final String? proxyAccountName; 
  final String mediaProxy;

  Meta(Map<String, dynamic> map)
  : maintainerName = map['maintainerName'] as String?,
    maintainerEmail = map['maintainerEmail'] as String?,
    version = map['version'] as String,
    name = map['name'] as String,
    uri = map['uri'] as String,
    description = map['description'] as String?,
    langs = List<String>.from(map['langs'] as List),
    tosUrl = map['tosUrl'] as String?,
    repositoryUrl = map['repositoryUrl'] as String,
    feedbackUrl = map['feedbackUrl'] as String,
    defaultDarkTheme = map['defaultDarkTheme'] as String?,
    defaultLightTheme = map['defaultLightTheme'] as String?,
    disableRegistration = map['disableRegistration'] as bool,
    cacheRemoteFiles = map['cacheRemoteFiles'] as bool,
    cacheRemoteSensitiveFiles = map['cacheRemoteSensitiveFiles'] as bool,
    emailRequiredForSignup = map['emailRequiredForSignup'] as bool,
    enableHcaptcha = map['enableHcaptcha'] as bool,
    hcaptchaSiteKey = map['hcaptchaSiteKey'] as String?,
    enableRecaptcha = map['enableRecaptcha'] as bool,
    recaptchaSiteKey = map['recaptchaSiteKey'] as String?,
    enableTurnstile = map['enableTurnstile'] as bool,
    turnstileSiteKey = map['turnstileSiteKey'] as String?,
    swPublickey = map['swPublickey'] as String?,
    mascotImageUrl = map['mascotImageUrl'] as String,
    bannerUrl = map['bannerUrl'] as String,
    serverErrorImageUrl = map['serverErrorImageUrl'] as String?,
    infoImageUrl = map['infoImageUrl'] as String?,
    notFoundImageUrl = map['notFoundImageUrl'] as String?,
    iconUrl = map['iconUrl'] as String?,
    maxNoteTextLength = map['maxNoteTextLength'] as num,
    requireSetup = map['requireSetup'] as bool?, 
    enableEmail = map['enableEmail'] as bool, 
    enableServiceWorker = map['enableServiceWorker'] as bool, 
    translatorAvailable = map['translatorAvailable'] as bool, 
    proxyAccountName = map['proxyAccountName'] as String?, 
    mediaProxy = map['mediaProxy'] as String;
}
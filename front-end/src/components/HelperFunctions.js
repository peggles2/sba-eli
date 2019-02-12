export function StripHtmlTags(someString) {
    if (someString) {
        return someString.replace(/(<([^>]+)>)/ig, "");
    }
    return someString
}
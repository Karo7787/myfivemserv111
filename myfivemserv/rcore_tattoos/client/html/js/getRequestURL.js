const RESOURCE_NAME = (window).GetParentResourceName ?
    (window).GetParentResourceName() :
    'rcore_tattoos';

export const getRequestUrl = (path) => `https://${RESOURCE_NAME}/${path}`;
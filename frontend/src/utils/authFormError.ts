import { isAxiosError } from 'axios';

export function authFormError(error: unknown, fallback: string): string {
  if (!isAxiosError(error)) return fallback;
  const data = error.response?.data;
  if (error.response?.status === 400 && data?.validationErrors && typeof data.validationErrors === 'object') {
    const messages = Object.values(data.validationErrors).filter(
      (message): message is string => typeof message === 'string' && message.length > 0,
    );
    if (messages.length) return [...new Set(messages)].join('. ');
  }
  return typeof data?.message === 'string' && data.message ? data.message : fallback;
}

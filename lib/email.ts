// app/lib/email.ts
import { SubscriptionConfirmation } from '@/app/emails/SubscriptionConfirmation';
import { Resend } from 'resend';

const resend = new Resend(process.env.RESEND_API_KEY);

export const sendSubscriptionConfirmation = async (email: string, name: string) => {
  try {
    const { error } = await resend.emails.send({
      from: 'Lingual <onboarding@resend.dev>',
      to: email,
      subject: 'Your Lingual Pro Subscription is Active!',
      react: SubscriptionConfirmation({ username: name }),
    });

    if (error) {
      console.error('Error sending email:', error);
      return false;
    }

    return true;
  } catch (error) {
    console.error('Failed to send confirmation email:', error);
    return false;
  }
};
import type { Metadata } from 'next';
import Link from 'next/link';
import { Code2, Compass, ArrowRightLeft, FileSearch, GraduationCap, HeartHandshake } from 'lucide-react';

import { Button } from '@/components/ui/button';
import { Card, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Footer } from '@/components/footer';
import { t } from '@/lib/i18n';

const contact = 'https://forms.gle/wdxmjUMbYEhoJTsN8';

export async function generateMetadata({ params }: { params: Promise<{ lang: string }> }): Promise<Metadata> {
  const { lang } = await params;
  return { title: t(lang).enterprise.metadataTitle };
}

export default async function EnterprisePage({ params }: { params: Promise<{ lang: string }> }) {
  const { lang } = await params;
  const text = t(lang).enterprise;

  const services = [
    { icon: Code2, ...text.services.development },
    { icon: Compass, ...text.services.guidance },
    { icon: ArrowRightLeft, ...text.services.migration },
    { icon: FileSearch, ...text.services.review },
    { icon: HeartHandshake, ...text.services.lts },
    { icon: GraduationCap, ...text.services.training },
  ];

  return (
    <main className="flex flex-col">
      {/* Hero Section */}
      <section className="flex flex-col items-center px-6 pt-6 pb-16 text-center">
        <div className="flex flex-col items-center justify-center sm:max-w-3xl mx-auto">
          <video autoPlay loop muted playsInline className="w-full max-w-sm px-10 mb-4 rounded-lg dark:invert">
            {/* codecs=hvc1 is a workaround as only safari appears to support it. Other browsers should fall back to webm. */}
            <source src="/assets/enterprise.mp4" type="video/mp4; codecs=hvc1" />
            <source src="/assets/enterprise.webm" type="video/webm" />
          </video>
          <h1 className="text-3xl sm:text-5xl font-bold tracking-tight mb-4">{text.heroTitle}</h1>
          <p className="text-base sm:text-lg text-muted-foreground max-w-2xl mb-6">{text.heroSubtitle}</p>
          <div className="flex gap-4">
            <Button asChild>
              <a href={contact} target="_blank" rel="noopener noreferrer">
                {text.getInTouch}
              </a>
            </Button>
            <Button variant="outline" asChild>
              <Link href="#services">{text.learnMore}</Link>
            </Button>
          </div>
        </div>
      </section>

      {/* Services Grid */}
      <section id="services" className="px-6 py-16 bg-muted/50">
        <div className="max-w-5xl mx-auto">
          <h2 className="text-3xl font-bold tracking-tight text-center mb-10">{text.servicesTitle}</h2>
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {services.map((service) => (
              <Card key={service.title} className="text-left">
                <CardHeader>
                  <service.icon className="size-8 mb-2 text-muted-foreground" />
                  <CardTitle>{service.title}</CardTitle>
                  <CardDescription>{service.description}</CardDescription>
                </CardHeader>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="px-6 py-16">
        <div className="max-w-xl mx-auto text-center">
          <h2 className="text-2xl sm:text-3xl font-bold tracking-tight mb-4 ">{text.ctaTitle}</h2>
          <p className="text-base sm:text-lg text-muted-foreground mb-6">{text.ctaSubtitle}</p>
          <Button size="lg" asChild>
            <a href={contact} target="_blank" rel="noopener noreferrer">
              {text.contactUs}
            </a>
          </Button>
        </div>
      </section>

      <Footer lang={lang} />
    </main>
  );
}

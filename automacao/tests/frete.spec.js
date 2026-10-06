const { test, expect } = require('@playwright/test');

test('CT007 - frete grátis para subtotal de R$ 200,00', async ({ page }) => {
  await page.goto('/');

  await page.getByText('Mochila Urbana 20L').click();

  const produto = page.getByRole('article', { name: 'Mochila Urbana 20L' });

  await produto.getByRole('button', { name: /adicionar/i }).click();
  await produto.getByRole('button', { name: /adicionar/i }).click();

  await page.getByRole('link', { name: /carrinho/i }).click();

  await expect(page.getByRole('region').getByText('R$ 200,00')).toBeVisible();

  await expect(
  page.getByRole('region').getByText('Grátis', { exact: true })
).toBeVisible();
});